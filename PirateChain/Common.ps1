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

function Select-AddressString {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, ValueFromPipeline)]
        $InputObject
    )

    process {
      $type = $InputObject.GetType().Name
      $addrString = ""
      if ($type -eq "String") {
          $addrString = $InputObject.Trim()
      }
      elseif($type -eq "PSCustomObject") {
          # assume it's an object resulting from Get-Address
          $addrString = $InputObject.Address.Trim()
      }
  
      if ($addrString -notmatch "^zs1[a-z0-9]{75}$") {
          throw ("Invalid address format: " + $addrString + ", type=$type")
      }
  
      $addrString
    }    
}