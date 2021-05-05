function Get-TotalBalance {
  param(
    [int]
    $Confirmations = 0,

    [Switch]
    $ExcudeWatchOnly
  )

  $excludeWatchOnlyArg = $ExcudeWatchOnly ? "false" : "true"
  $result = (pirate-cli z_gettotalbalance $Confirmations $excludeWatchOnlyArg | ConvertFrom-Json)
  return $result.total
}