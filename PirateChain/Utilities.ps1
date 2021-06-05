$ARRTOSHI = 0.000001

function ConvertTo-RpcJsonArray {
    param(
        [Parameter(ValueFromPipeline)]
        $Obj
    )

    ($Obj | ConvertTo-Json -AsArray -Compress) -replace '"', '\"'
}

function Format-TimeSpan {
    param(
        [Parameter(ValueFromPipeline)]
        $TimeSpan
    )

    if ($TimeSpan.TotalDays -ge 7) {
        $totalWeeks = $TimeSpan.TotalDays/7
        $remainingDays = $TimeSpan.TotalDays - ([Math]::Floor($totalWeeks) * 7)
        ("{0:0}w{1:0}d" -f $totalWeeks, $remainingDays)
    }
    elseif ($TimeSpan.TotalDays -gt 1) {
        ("{0:0}d" -f $TimeSpan.Days)
    }
    else {
        ("{0}h{1}m" -f $TimeSpan.Hours, $TimeSpan.Minutes)
    }
}