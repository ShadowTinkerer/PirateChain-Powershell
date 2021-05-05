function Get-OperationResult {
  param(
    $Id
  )

  $idsJson = @($Id) | ConvertTo-RpcJsonArray
  pirate-cli z_getoperationresult $idsJson | ConvertFrom-Json
}