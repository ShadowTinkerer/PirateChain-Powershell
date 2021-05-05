<#
.SYNOPSIS
Export the viewing key of an address

.PARAMETER Address
Parameter description

.EXAMPLE
Get-ViewingKey zs1xxxxxxxxxx

Get-Address 0 | Get-ViewingKey
#>
function Get-ViewingKey {
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

  pirate-cli z_exportviewingkey $AddressString
}