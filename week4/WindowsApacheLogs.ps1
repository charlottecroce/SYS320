# 2. list all the apache logs of XAMPP
Get-Content C:\xampp\apache\logs\access.log

# 3. list last 5 lines of the apache logs of XAMPP
Get-Content C:\xampp\apache\logs\access.log -Tail 5

# 4. display only 404 and 400 errors
Get-Content C:\xampp\apache\logs\access.log | Select-String ' 404 ', ' 400 '

# 5. display all logs that are NOT code 200
Get-Content C:\xampp\apache\logs\access.log | Select-String ' 200 '

# 6. from every file with .log extension, get those that contain the word '-error'
$A = Get-ChildItem C:\xampp\apache\logs\*.log | Select-String 'error'
# select last 5 from array
$A[-5..-1]

# 7. display ip addresses for 404 errors
$notfounds = Get-Content C:\xampp\apache\logs\access.log  | Select-String ' 404 '
$regex = [regex] "[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}"
$ipsunorganized = $regex.Matches($notfounds)

$ips = @()
for($i=0; $i -lt $ipsunorganized.Count; $i++){
    $ips += [pscustomobject]@{ "IP" = $ipsunorganized[$i].Value; }
}
$ips | Where-Object { $_.IP -ilike "10.*" }

# 8. count ips from previous output
$ipsoftens = $ips | Where-Object { $_.IP -ilike "10.*" }
$counts = $ipsoftens | Group-Object IP
$counts | Select-Object Count, Name


# 9
# run external script Apache-Logs.ps1
#(Join-Path $PSScriptRoot C:\Users\champuser\SYS320\week4\Apache-Logs.ps1)
. "C:\Users\champuser\SYS320\week4\Apache-Logs.ps1"

$ips = Apache-Logs "/*external*" "404" "Mozilla/5.0"
#$ips