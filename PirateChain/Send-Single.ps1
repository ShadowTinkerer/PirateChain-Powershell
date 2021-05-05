function Send-Single {
  param(
    [Parameter(Mandatory)]
    $FromAddress,

    [Parameter(Mandatory)]
    [string]
    $ToAddress,

    [Parameter(Mandatory)]
    $Amount,

    [string]
    $Memo,

    [Switch]
    $NoWaitForCompletion
  )

  $memoHex = $Memo ? [Convert]::ToHexString([Text.Encoding]::UTF8.GetBytes($Memo)) : ""
  $recipients = @(
    @{
      "address" = $ToAddress
      "amount"  = "$Amount"
      "memo"    = $memoHex
    }
  )
  $recipientsJson = $recipients | ConvertTo-RpcJsonArray
  $args = @(
    "z_sendmany"
    $FromAddress
    $recipientsJson
  )
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