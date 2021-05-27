function Send-Single {
  param(
    [Parameter(Mandatory)]
    [string]
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
  
  $recipient = @{
    "address" = $ToAddress
    "amount"  = "$Amount"
  }
  if($Memo) {
    $recipient["memo"] = [Convert]::ToHexString([Text.Encoding]::UTF8.GetBytes($Memo))
  }
  $recipients = @($recipient)
  $recipientsJson = $recipients | ConvertTo-RpcJsonArray
  $args = @(
    "z_sendmany"
    $FromAddress
    $recipientsJson
  )
  $OpId = pirate-cli @args
  if(!$?) {
    return
  }

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