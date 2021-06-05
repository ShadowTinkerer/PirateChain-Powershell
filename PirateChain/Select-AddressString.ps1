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