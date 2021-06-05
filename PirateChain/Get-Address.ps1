<#
.SYNOPSIS
List the addresses within the wallet, along with their balance.

.DESCRIPTION
A convenience method for listing all the wallet's addresses, allowing to apply optional filters to the result.

.PARAMETER ExcludeWatchOnly
Use this switch to exclude the addresses without a SpendingKey

.PARAMETER WithNonZeroBalance
Use this switch to only include addresses with a non-zero balance

.PARAMETER Unused
Use this switch to only include addresses that never received a payment. Test-IsAddressUsed is invoked to determine that.

.EXAMPLE
# List all the wallet addresses
Get-Address

# List only the addresses that are not watch-only

.NOTES
General notes
#>
function Get-Address {
    param(
        [Switch]
        $ExcludeWatchOnly,

        [Parameter(ParameterSetName = "UsedFilter")]
        [Switch]
        $WithNonZeroBalance,

        [Parameter(ParameterSetName = "UsedFilter")]
        [Switch]
        $Unused
    )

    $watchOnlyParam = $ExcludeWatchOnly ? "false" : "true"
    $addresses = Invoke-PirateCli "z_listaddresses", $watchOnlyParam | convertFrom-Json

    $addressObjects = $addresses | Foreach-Object {
        $addrMap = @{
            "Address" = $_
            "Balance" = Get-AddressBalance $_
        }
        if($ExcludeWatchOnly) {
          $addrMap["hasSpendingKey"] = $true
        }

        return [PSCustomObject] $addrMap
    }

    if($WithNonZeroBalance) {
      $addressObjects = $addressObjects | Where-Object { $_.Balance -ge $ARRTOSHI }
    }

    if($Unused) {
      $addressObjects = $addressObjects | Where-Object { $_.Balance -lt $ARRTOSHI } | Where-Object { !(Test-IsAddressUsed $_) }
    }

    return $addressObjects
}