$string="Feature1,Feature2,Feature3"

$array = $string -split ","

foreach ($item in $array) {
  # Code to process each item
  # Write-Host "LABEL: $item"
  $env:LIQUIBASE_COMMAND_LABELS = $item
  Write-Host "LIQUIBASE_COMMAND_LABELS: @$env:LIQUIBASE_COMMAND_LABELS"
  # liquibase status
  liquibase flow
}