<#
.SYNOPSIS
Get the balance of an address

.PARAMETER Address
Parameter description

.EXAMPLE
Get-AddressBalance 

.NOTES
General notes
#>
function Get-AddressBalance {
  param(
    [Parameter(Mandatory, ValueFromPipeline)]
    $Address
  )

  process {
    $addressString = (Select-AddressString $Address)

    $args = @(
      "z_getbalance"
      $addressString
    )
    pirate-cli @args | ConvertFrom-Json
  }
}