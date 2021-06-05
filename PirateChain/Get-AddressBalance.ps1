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
    Invoke-PirateCli "z_getbalance", (Select-AddressString $Address) | ConvertFrom-Json
  }
}