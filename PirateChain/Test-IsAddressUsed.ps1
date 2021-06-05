<#
.SYNOPSIS
Test if an address has ever received a payment.

.DESCRIPTION
Returns true if the address has ever received a payment, false otherwise.

.PARAMETER Address
A Z-Address string, or a PSCustomObject containing an Address property (i.e. what is returned from Get-Address)

.EXAMPLE
if(!(Test-IsAddressUsed "z_addr1")) {
  Write-Host "This address was never used""
}

.NOTES
General notes
#>
function Test-IsAddressUsed {
  [CmdletBinding()]
  param(
    [Parameter(Mandatory, ValueFromPipeline)]
    $Address
  )

  begin {
    $minConfirmations = 0
    $filterType = 0
    $filterValue = 0
    $count = 1
  }

  process {
    $addressString = Select-AddressString $Address
    
    $result = Invoke-PirateCli "zs_listreceivedbyaddress", $addressString, $minConfirmations, $filterType, $filterValue, $count | ConvertFrom-Json
    if($result -or ($Address | Test-IsObjectWithProperty "hasSpendingKey" -PropertyValue $true)) {
      return !!$result
    }
  
    # As zs_listreceivedbyaddress only works for addresses with spending keys, we need to check again using the more costly call:
    $result = Invoke-PirateCli "z_listreceivedbyaddress", $addressString, $minConfirmations | ConvertFrom-Json
    return !!$result
  }
}