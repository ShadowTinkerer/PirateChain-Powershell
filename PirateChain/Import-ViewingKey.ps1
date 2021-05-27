function Import-ViewingKey {
  [CmdletBinding()]
  param(
    [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
    [string[]]
    $Address,

    [Switch]
    $Rescan,

    [int]
    $RescanHeight
  )

  process {
    $params = @(
      "z_importviewingkey",
      $Address
    )

    if($Rescan -or $RescanHeight) {
      $params += "yes"
      if($RescanHeight) {
        $params += $RescanHeight
      }
    }

    pirate-cli @params
  }
}