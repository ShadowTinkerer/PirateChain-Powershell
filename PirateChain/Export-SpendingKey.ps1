<#
.SYNOPSIS
Export the Spending Key of an Address.

.DESCRIPTION
If the SpendingKey is not available in the wallet, an empty string is returned.

.PARAMETER Address
A Z-Address string, or a PSCustomObject containing an Address property (i.e. what is returned from Get-Address)

.EXAMPLE
# Simple Usage
Export-SpendingKey "z_address"

# Array of addresses
"z_address1", "z_address2" | Export-SpendingKey

# Pipelining from Get-Address
Get-Address | Export-SpendingKey

.NOTES
RPC method name: z_exportkey
#>
function Export-SpendingKey {
  [CmdletBinding()]
  param(
    [Parameter(Mandatory, ValueFromPipeline)]
    [string[]]
    $Address
  )

  process {
    $result = Invoke-PirateCli "z_exportkey", $Address -IgnoredErrorCodes -4
    if(!$?) {
      return ""
    }

    return $result
  }
}