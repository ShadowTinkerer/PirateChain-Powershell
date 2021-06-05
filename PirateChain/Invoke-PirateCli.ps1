
class PirateCliInvocationException : Exception {
  [int] $errorCode

  PirateCliInvocationException($message, $errorCode) : base("pirate-cli error: $message") {
    $this.errorCode = $errorCode
  }
}

function Invoke-PirateCli
{
  param(
    [Parameter(Position=0, Mandatory)]
    [string[]]
    $Arguments,

    # If one of those error codes are returned, the CmdLet will return an empty string instead of throwing an Exception.
    [int[]]
    $IgnoredErrorCodes
  )

  $startInfo = [diagnostics.ProcessStartInfo]::new("pirate-cli", $Arguments)
  $startInfo.UseShellExecute = $false
  $startInfo.RedirectStandardOutput = $true
  $startInfo.RedirectStandardError = $true

  Write-Verbose ($startInfo.FileName + " " + $Arguments)
  $process = [diagnostics.Process]::Start($startInfo)
  $process.WaitForExit()

  $stdOutput = $process.StandardOutput.ReadToEnd()
  $errOutput = $process.StandardError.ReadToEnd()

  if($errOutput -match "error code: (.+)\nerror message:\n(.+)") {
    $errorCode = $Matches.1
    $errorMessage = $Matches.2

    if($IgnoredErrorCodes -and $IgnoredErrorCodes -contains $errorCode) {
      return ""
    }

    throw [PirateCliInvocationException]::new($errorMessage, $errorCode)
  }

  $stdOutput
}