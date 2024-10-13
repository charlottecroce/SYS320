# 9/26/24

# parses apache log into pscustomobjects, filters IPs for 10.*
function ApacheLogs1(){
$logsnotformatted = Get-Content C:\xampp\apache\logs\access.log
$tablerecords = @()

    for($i=0; $i -lt $logsnotformatted.Length; $i++){

        # split string into words
        $words = $logsnotformatted[$i] -split " "

        $tablerecords += [pscustomobject]@{"IP" = $words[0]; `
                                           "Time" = $words[3].Trim('['); `
                                           "Method" = $words[5].Trim('"'); `
                                           "Page" = $words[6]; `
                                           "Protocol" = $words[7]; `
                                           "Response" = $words[8]; `
                                           "Referrer" = $words[10]; `
                                           "Client" = -join $words[11..($words.Length - 1)]; }
    }# end of for loop

    return $tablerecords | Where-Object { $_.IP -ilike "10.*"}
}
$tablerecords = ApacheLogs1
#$tablerecords
