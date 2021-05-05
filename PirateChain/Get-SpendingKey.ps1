<#
.SYNOPSIS
Export the spending (private) key of an address

.PARAMETER Address
Parameter description

.EXAMPLE
Get-SpendingKey zs1xxxxxxxxxx

Get-Address 0 | Get-SpendingKey
#>
function Get-SpendingKey {
  param(
    [Parameter(Mandatory, ValueFromPipeline)]
    $Address
  )

  if ($Address.GetType().Name -eq "String") {
    $AddressString = $Address
  }
  else {
    # assume it's an object resulting from Get-Address
    $AddressString = $Address.Address
  }

  pirate-cli z_exportkey $AddressString
}