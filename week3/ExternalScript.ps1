(Join-Path $PSScriptRoot .\FunctionsAndEventLogs.ps1)

$loginoutsTable = FunctionsAndEventLogs.getWinLogons(14)
$loginoutsTable
