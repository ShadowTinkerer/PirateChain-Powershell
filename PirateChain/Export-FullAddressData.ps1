<#
.SYNOPSIS
Create an object containing the address, viewingKey and spendingKey of an Address.

.DESCRIPTION
ViewingKeys and SpendingKeys are exported. If spendingKey is missing, the field is empty. This Cmdlet supports pipelining.

.PARAMETER Address
A Z-Address string, or a PSCustomObject containing an Address property (i.e. what is returned from Get-Address)

.EXAMPLE
# Single address
Export-FullAddressData "z_address"

# Array of addresses
"z_address1", "z_address2" | Export-FullAddressData

# Pipelining from Get-Address
Get-Address | Export-FullAddressData | ConvertTo-Json | Out-File "full-wallet-backup.json"
#>
function Export-FullAddressData {
  [CmdletBinding()]
  param(
    [Parameter(ValueFromPipeline, Mandatory)]
    $Address
  )

  process {
    $addressString = Select-AddressString $Address
    return [PSCustomObject] @{
      "address" = $addressString
      "viewingKey" = Export-ViewingKey $addressString
      "spendingKey" = Export-SpendingKey $addressString
    }
  }
}