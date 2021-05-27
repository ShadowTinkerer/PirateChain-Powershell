function Import-SpendingKey {
  [CmdletBinding()]
  param(
    [Parameter(Mandatory, ValueFromPipeline)]
    [string[]]
    $Address
  )

  process {
    pirate-cli z_importkey $Address
  }
}