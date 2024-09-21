
function ApacheLogs1(){
$logsnotformatted = Get-Content C:\xampp\apache\logs\access.log
$tablerecords = @()

$logsnotformatted.Length

for($i=0, $i -lt $logsnotformatted.Count, $i++){

$word = $logsnotformatted[$i].Split(" ")

$tablerecords += [pscustomobject]@{"IP"="$word[0]"; `
                                   "Time"="Time"; `
                                   "Method"="method"; `
                                   "Page"="page"; `
                                   "Protocol"="prot"; `
                                   "Response"="resp"; `
                                   "Referrer"="ref"; `
                                   "Client"="client"; }
        }# end of for loop
return $tablerecords | Where-Object { $_.IP -ilike "10.*"}
}
$tablerecords = ApacheLogs1
$tablerecords
