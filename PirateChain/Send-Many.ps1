<#
.SYNOPSIS
Send ARRR to multiple recipients

.DESCRIPTION
Long description

.PARAMETER FromAddress
Parameter description

.PARAMETER Recipients
Parameter description

.PARAMETER NoWaitForCompletion
Parameter description

.EXAMPLE
Send-Many -FromAddress "zs1" `
          -Recipients @(
              @{ "ToAddress" = "zs1a.."; "Amount" = "100"; "Memo" = "Hello, Word!" },
              @{ "ToAddress" = "zs1b.."; "Amount" = "2" }
)

.NOTES
General notes
#>
function Send-Many {
  [CmdletBinding()]
  param(
    [Parameter(Mandatory=$true, ValueFromPipeline=$true, Position = 0)]
    $Amounts,

    [Parameter(Mandatory, Position = 1)]
    [string]
    $FromAddress,

    [Switch]
    $NoWaitForCompletion
  )

  begin {
    $recipientsOutput = [Collections.ArrayList] @()
  }

  Process {
    $inputRecipient = Convert-Recipient $_
    $memoHex = $inputRecipient.psobject.Properties.match('memo') `
      ? [Convert]::ToHexString([Text.Encoding]::UTF8.GetBytes($inputRecipient.memo)) `
      : ""
    $recipient = @{
      "address" = $_.address
      "amount"  = $_.amount.ToString()
      "memo"    = $memoHex
    }
    $recipientsOutput.Add($recipient)
  }

  end {
    $recipientsJson = $recipientsOutput | ConvertTo-RpcJsonArray
    $args = @(
      "z_sendmany"
      $FromAddress
      $recipientsJson
    )
    
    Write-Verbose ([string] $args)
    $OpId = pirate-cli @args
  
    if (!$NoWaitForCompletion) {
      while (1) {
        Clear-Host
        $status = Get-OperationStatus $OpId
        $status
        if ($status.status -ne "executing") {
          Clear-Host
          Get-OperationResult $OpId
          break
        }
        sleep 1
      }
    }
  }
}

<#
.SYNOPSIS
Convert a recipient object to a PSCustomObject
#>
function Convert-Recipient {
  param(
    [Parameter(Position = 0)]
    $Recipient
  )
  
  $type = $Recipient.GetType().Name
  switch ($type) {
    "Hashtable"      { [PSCustomObject] $Recipient }
    "PSCustomObject" { $Recipient }
    Default { throw "Recipient's type: $type $ is not supported. Expected Hashtable or PSCustomObject." }
  }
}