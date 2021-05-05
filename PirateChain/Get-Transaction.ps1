function Get-Transaction {
  param(
    [Parameter(Mandatory, ValueFromPipeline)]
    $TransactionId
  )

  pirate-cli z_viewtransaction $TransactionId | ConvertFrom-Json
}