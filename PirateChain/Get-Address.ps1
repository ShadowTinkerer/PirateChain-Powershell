function Get-Address {
    param(
        [Parameter(Position = 0)]
        [Int]
        $Index,
    
        [Switch]
        $ExcludeWatchOnly
    )

    $watchOnlyParam = $ExcludeWatchOnly ? "false" : "true"
    $records = pirate-cli z_listaddresses $watchOnlyParam | convertFrom-Json

    if ($PSBoundParameters.ContainsKey("Index")) {
        $addresses = $records | Select-Object -Index $Index
    }
    else {
        $addresses = $records
    }

    $addresses | Foreach-Object {
        [PSCustomObject] @{
            "Address" = $_
            "Balance" = Get-AddressBalance $_
        }
    }
}