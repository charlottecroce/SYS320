(Join-Path $PSScriptRoot .\FunctionsAndEventLogs.ps1)

# get login and logoffs from past 14 days
$loginoutsTable = getWinLogons(14)
$loginoutsTable

# get shutdowns from past 20 days
$shutdownsTable = getShutdowns(20)
$shutdownsTable
