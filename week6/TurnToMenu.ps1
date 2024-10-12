. (Join-Path $PSScriptRoot ../week4/ParsingApacheLogs.ps1)

. (Join-Path $PSScriptRoot Users.ps1)
. (Join-Path $PSScriptRoot Event-Logs.ps1)

clear

$Prompt  = "Please choose your operation:`n"
$Prompt += "1 - Display last 10 apache logs`n"
$Prompt += "2 - Display last 10 failed logins (all users)`n"
$Prompt += "3 - Display At Risk users`n"
$Prompt += "4 - Start Chrome`n"
$Prompt += "5 - Exit`n"


$operation = $true

while($operation){

    
    Write-Host $Prompt | Out-String
    $choice = Read-Host 


    if($choice -eq 5){
        Write-Host "Goodbye" | Out-String
        exit
        $operation = $false 
    }

    #display last 10 apache logs
    elseif($choice -eq 1){1
        $apachelogs= ApacheLogs1
        $apachelogs[-10..-1] | Select IP, Time, Method, Page, Protocol, Response, referrer, Client | Out-String
    }

    #display last 10 failed logins(all user)
    elseif($choice -eq 2){
        $failedlogins = getFailedLogins 90
        $failedlogins[-10..-1] | Select Time, User | Out-String
    }

    #display at risk users
    elseif($choice -eq 3){
        $timeSince = Read-Host -Prompt "enter number of days to search back"
        $atRiskUsers = getAtRiskUsers $timeSince

        Write-Host ($atRiskUsers | Format-Table | Out-String)
    }

    # start chrome, and navigate to champlain.edu - if no instance of chrome is running
    elseif($choice -eq 4){
        if(Get-Process -Name chrome -ErrorAction SilentlyContinue){
            Write-Host "Chrome Already Running."
        }
        else{
            Write-Host "Chrome not running. Starting now"
            Start-Process 'C:\Program Files\Google\Chrome\Application\chrome.exe' `
            '--new-window https://champlain.edu'
        }
    }

    else{
        Write-Host "invalid input. 1-5 allowed`n"
    }

}