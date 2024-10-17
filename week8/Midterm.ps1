
# 1. Function to get IOC table from the given web page
function getIOCTable(){

    $page = Invoke-WebRequest -TimeoutSec 10 http://10.0.17.5/IOC.html

    # get all tr elements
    $trs=$page.ParsedHTML.body.getElementsByTagName("tr")

    # array to hold results
    $IOCTable = @()
    for($i=1; $i -lt $trs.length; $i++){
        # get every td element of current tr element
           $tds= $trs[$i].getElementsByTagName("td")
           $IOCTable += [pscustomobject]@{"Pattern" = $tds[0].innerText; "Explanation" = $tds[1].innerText; }                                 
    }# for loop end

        return $IOCTable
} # function end

# getIOCTable | Format-Table

# 2. function to get Apache Access logs
function getApacheLogs(){
    $logs = Get-Content "C:\Users\champuser\SYS320\week8\access.log"
    $logTable = @()

    for($i=0; $i -lt $logs.Length; $i++){

        # split string into words
        $words = $logs[$i] -split " "

        $logTable += [pscustomobject]@{"IP" = $words[0]; `
                                           "Time" = $words[3].Trim('['); `
                                           "Method" = $words[5].Trim('"'); `
                                           "Page" = $words[6]; `
                                           "Protocol" = $words[7]; `
                                           "Response" = $words[8]; `
                                           "Referrer" = $words[10]; ` }
    }# for loop end

    return $logTable
} # function end

# getApacheLogs | Format-Table


# 3. get Apache logs, but only display those that have an IOC in the page field
function getIOCLogs(){
    $logTable = getApacheLogs
    $IOCTable = getIOCTable

    $IOCLogTable = @()
    for($i = 0; $i -lt $logTable.Count; $i++){
        for($j = 0; $j -lt $IOCTable.Count; $j++){
            if ($logTable[$i].Page -match $IOCTable[$j].Pattern){
                $IOCLogTable += $logTable[$i]
            } # if end
        } # inner for loop end
    } # outer for loop end
   
   return $IOCLogTable

} # function end

getIOCLogs | Format-Table

