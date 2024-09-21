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
$notfounds = Get-Content C:\xampp\apache\logs\access.log | Select-String ' 404 '
$notfounds
$regex = [regex] "\d{1-3}.\d{1-3}.\d{1-3}.\d{1-3}"
$ipsunorganized = [regex]::Matches($notfounds, $regex)
$ipsunorganized

