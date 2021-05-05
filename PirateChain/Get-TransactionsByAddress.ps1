function Get-TransactionsByAddress {
  param(
    [Parameter(Mandatory, ValueFromPipeline)]
    $Address
  )

  $addressString = Select-AddressString $Address

  $transactions = pirate-cli z_listreceivedbyaddress $addressString
  | convertfrom-json `
    | Select-Object -Property txid, amount, confirmations `
    | foreach-object {
    [PSCustomObject] @{
      "txid"          = $_.txid
      "amount"        = [double][Math]::Round($_.amount, 4)
      "confirmations" = [int]$_.confirmations
      "age"           = (New-TimeSpan -Minutes $_.confirmations) | Format-TimeSpan
    }
  }
  | Sort-Object -Property confirmations -Descending

  ($transactions | Format-Table)

  $totalAmount = ($transactions | Measure-Object -Property amount -Sum).Sum
  Write-Host "total: $totalAmount"
}