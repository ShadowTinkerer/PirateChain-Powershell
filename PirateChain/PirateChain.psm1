Set-StrictMode -Version 3
$ErrorActionPreference = "Stop"

. $PSScriptRoot/Utilities.ps1
. $PSScriptRoot/Test-IsAddressUsed.ps1
. $PSScriptRoot/Invoke-PirateCli.ps1
. $PSScriptRoot/Select-AddressString.ps1

. $PSScriptRoot/New-Address.ps1
. $PSScriptRoot/Get-Address.ps1
. $PSScriptRoot/Get-AddressBalance.ps1
. $PSScriptRoot/Get-OperationResult.ps1
. $PSScriptRoot/Get-OperationStatus.ps1
. $PSScriptRoot/Get-AddressBalance.ps1
. $PSScriptRoot/Get-TotalBalance.ps1
. $PSScriptRoot/Get-TransactionsByAddress.ps1
. $PSScriptRoot/Get-ViewingKey.ps1
. $PSScriptRoot/Get-SpendingKey.ps1
. $PSScriptRoot/Send-Single.ps1
. $PSScriptRoot/Send-Many.ps1
. $PSScriptRoot/Import-ViewingKey.ps1
. $PSScriptRoot/Import-SpendingKey.ps1
. $PSScriptRoot/Export-ViewingKey.ps1
. $PSScriptRoot/Export-SpendingKey.ps1
. $PSScriptRoot/Export-FullAddressData.ps1
. $PSScriptRoot/Get-Transaction.ps1

Export-ModuleMember -Function Invoke-PirateCli
Export-ModuleMember -Function Select-AddressString
Export-ModuleMember -Function Test-IsAddressUsed
Export-ModuleMember -Function Test-IsObjectWithProperty

Export-ModuleMember -Function New-Address
Export-ModuleMember -Function Get-Address
Export-ModuleMember -Function Get-AddressBalance
Export-ModuleMember -Function Get-OperationResult
Export-ModuleMember -Function Get-OperationStatus
Export-ModuleMember -Function Get-AddressBalance
Export-ModuleMember -Function Get-TotalBalance
Export-ModuleMember -Function Get-TransactionsByAddress
Export-ModuleMember -Function Get-ViewingKey
Export-ModuleMember -Function Get-SpendingKey
Export-ModuleMember -Function Get-Transaction
Export-ModuleMember -Function Import-ViewingKey
Export-ModuleMember -Function Import-SpendingKey
Export-ModuleMember -Function Export-ViewingKey
Export-ModuleMember -Function Export-SpendingKey
Export-ModuleMember -Function Export-FullAddressData

Export-ModuleMember -Function Send-Single
Export-ModuleMember -Function Send-Many
Export-ModuleMember -Function Convert-Recipient