# 9/26/24

# input page name, http code, and browser
# output IP addresses that visited the given page, with given browser, and got given HTTP response
Function Apache-Logs ([string]$page, [string]$HTTPcode, [string]$browser){
    $logsnotformatted = Get-Content C:\xampp\apache\logs\access.log
    $tablerecords = @()

    for($i=0; $i -lt $logsnotformatted.Length; $i++){

        # split string into words
        $words = $logsnotformatted[$i] -split " "

        # filter out logs that don't match inputs
        if(($words[6] -inotlike $page) -OR ($words[8] -inotcontains $HTTPcode) `
        -OR ($words[11].Trim('"') -inotlike $browser)){
            continue
        }

        # create custom objects for matches
        $tablerecords += [pscustomobject]@{"IP" = $words[0]; `
                                           "Page" = $words[6]; `
                                           "Response" = $words[8]; `
                                           "Browser" = -join $words[11..($words.Length - 1)]; }
    }# end of for loop
    
    return $tablerecords

}
#$ips1 = Apache-Logs "/index.html" "200" "Mozilla/5.0"
#$ips1

#$ips2 = Apache-Logs "/*external*" "404" "Mozilla/5.0"
#$ips2