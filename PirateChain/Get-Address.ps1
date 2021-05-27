function Get-Address {
    param(
        [Parameter(Position = 0)]
        [Int]
        $Index,
    
        [Switch]
        $ExcludeWatchOnly,

        [Switch]
        $WithNonZeroBalance
    )

    $watchOnlyParam = $ExcludeWatchOnly ? "false" : "true"
    $records = pirate-cli z_listaddresses $watchOnlyParam | convertFrom-Json

    if ($PSBoundParameters.ContainsKey("Index")) {
        $addresses = $records | Select-Object -Index $Index
    }
    else {
        $addresses = $records
    }

    $addressObjects = $addresses | Foreach-Object {
        [PSCustomObject] @{
            "Address" = $_
            "Balance" = Get-AddressBalance $_
        }
    }

    if($WithNonZeroBalance) {
      $addressObjects = $addressObjects | Where-Object { $_.Balance -ge $ARRTOSHI }
    }

    return $addressObjects
}