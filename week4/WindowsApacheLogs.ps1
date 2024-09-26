# list all the apache logs of XAMPP
#Get-Content C:\xampp\apache\logs\access.log

# list last 5 lines of the apache logs of XAMPP
#Get-Content C:\xampp\apache\logs\access.log -Tail 5

# display only 404 and 400 errors
#Get-Content C:\xampp\apache\logs\access.log | Select-String ' 404 ', ' 400 '

# display all logs that are NOT code 200
#Get-Content C:\xampp\apache\logs\access.log | Select-String ' 200 '

# from every file with .log extension, get those that contain the word '-error'
#$A = Get-ChildItem C:\xampp\apache\logs\*.log | Select-String 'error'
# select last 5 from array
#$A[-5..-1]


# display ip addresses for 404 errors
$notfounds = Get-Content C:\xampp\apache\logs\access.log  | Select-String ' 404 '

$regex = [regex] "[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}"
$ipsunorganized = $regex.Matches($notfounds)

$ips = @()
for($i=0; $i -lt $ipsunorganized.Count; $i++){
    $ips += [pscustomobject]@{ "IP" = $ipsunorganized[$i].Value; }
}
#$ips | Where-Object { $_.IP -ilike "10.*" }

# count ips from previous output
$ipsoftens = $ips | Where-Object { $_.IP -ilike "10.*" }
Write-Host $ipsoftens
#$counts = $ipsoftens | Group-Object
#$counts | Select-Object Count, Name