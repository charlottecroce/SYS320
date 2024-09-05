#9/5/24

# List every process for which ProcessName starts with 'C'
Get-Process | Where-Object { $_.Name -ilike "C*"}

#list every process for which the path does not include the string "system32"
Get-Process | Where-Object { $_.Name -inotlike "*system32*"}

