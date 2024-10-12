#9/5/24

# 1. List every process for which ProcessName starts with 'C'
Get-Process | Where-Object { $_.Name -ilike "C*"}

# 2. List every process for which the path does not include the string "system32"
Get-Process | Where-Object { $_.Name -inotlike "*system32*"}

# 3. List every stopped service, order alphabetically, and export to csv
Get-Service | Where-Object { $_.Status -eq "Stopped" } | `
Sort-Object | Export-Csv -Path StoppedServices.csv

# 4. If Google Chrome browser is not running, start it and direct to champlain.edu
#    If it is already running, stop it
if (Get-Process -Name chrome -ErrorAction SilentlyContinue){
    Write-Host "Chrome Running. Stopping now"
    Get-Process -name chrome | Stop-Process
}
else{
    Write-Host "Chrome not running. Starting now"
    Start-Process 'C:\Program Files\Google\Chrome\Application\chrome.exe' `
    '--new-window https://champlain.edu'
}


