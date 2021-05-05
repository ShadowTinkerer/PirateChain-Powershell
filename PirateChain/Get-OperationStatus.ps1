
function Get-OperationStatus {
  param(
    $Id
  )

  $idsJson = @($Id) | ConvertTo-RpcJsonArray
  pirate-cli z_getoperationstatus $idsJson | ConvertFrom-Json
}