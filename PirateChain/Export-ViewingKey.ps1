<#
.SYNOPSIS
Export the Viewing Key of an Address

.PARAMETER Address
A Z-Address string, or a PSCustomObject containing an Address property (i.e. what is returned from Get-Address)

.EXAMPLE
# Simple Usage
Export-SpendingKey "z_address"

# Array of addresses
"z_address1", "z_address2" | Export-Export-ViewingKey

# Pipelining from Get-Address
Get-Address | Export-ViewingKey

.NOTES
RPC method name: z_exportviewingkey
#>
function Export-ViewingKey {
  [CmdletBinding()]
  param(
    [Parameter(Mandatory, ValueFromPipeline)]
    [string[]]
    $Address
  )

  process {
    Invoke-PirateCli "z_exportviewingkey", $Address
  }
}