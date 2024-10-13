. (Join-Path $PSScriptRoot Users.ps1)
. (Join-Path $PSScriptRoot Event-Logs.ps1)

clear

$Prompt  = "Please choose your operation:`n"
$Prompt += "1 - List Enabled Users`n"
$Prompt += "2 - List Disabled Users`n"
$Prompt += "3 - Create a User`n"
$Prompt += "4 - Remove a User`n"
$Prompt += "5 - Enable a User`n"
$Prompt += "6 - Disable a User`n"
$Prompt += "7 - Get Log-In Logs`n"
$Prompt += "8 - Get Failed Log-In Logs`n"
$Prompt += "9 - List at Risk Users`n"
$Prompt += "0 - Exit`n"



$operation = $true

while($operation){

    
    Write-Host $Prompt | Out-String
    $choice = Read-Host 

    # exit
    if($choice -eq 0){
        Write-Host "Goodbye" | Out-String
        exit
        $operation = $false 
    }

    # get enabled users
    elseif($choice -eq 1){
        $enabledUsers = getEnabledUsers
        Write-Host ($enabledUsers | Format-Table | Out-String)
    }

    #get not enabled users
    elseif($choice -eq 2){
        $notEnabledUsers = getNotEnabledUsers
        Write-Host ($notEnabledUsers | Format-Table | Out-String)
    }


    # Create a user
    elseif($choice -eq 3){ 

        $name = Read-Host -Prompt "Please enter the username for the new user"
        
        $chkuser = checkuser $name
        if($chkuser -ne $true){  # check if user already exists      
            $password = Read-Host -AsSecureString -Prompt "Please enter the password for the new user"
            $bstr = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($password)
            $plainpassword = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($bstr)
            $chkPasswd = checkpassword $plainpassword

            if($chkPasswd -ne $false){ # check if password is valid
               createAUser $name $password
               Write-Host "User: $name is created." | Out-String
            }
            else{ Write-Host "invalid password" | Out-String }
       
        }
        else { Write-Host "user already exists" | Out-String}
    }


    # Remove a user
    elseif($choice -eq 4){

        $name = Read-Host -Prompt "Please enter the username for the user to be removed"

        $chkUser = checkuser $name
        if($chkUser -eq $true){# check if user already exists
            removeAUser $name
            Write-Host "User: $name Removed." | Out-String
        }
        else { Write-Host "user does not exist" | Out-String }
    }


    # Enable a user
    elseif($choice -eq 5){


        $name = Read-Host -Prompt "Please enter the username for the user to be enabled"

        $chkUser = checkuser $name
        
        if($chkUser -eq $true){ # check if user already exists
            enableAUser $name
            Write-Host "User: $name Enabled." | Out-String
        }
        else { Write-Host "user does not exist" | Out-String }

    }


    # Disable a user
    elseif($choice -eq 6){

        $name = Read-Host -Prompt "Please enter the username for the user to be disabled"

        $chkUser = checkuser $name
        if($chkUser -eq $true){ # check if user already exists
            disableAUser $name
            Write-Host "User: $name Disabled." | Out-String
        }
        else{ Write-Host "user does not exist" | Out-String }
    }

    # get login logs
    elseif($choice -eq 7){

        $name = Read-Host -Prompt "Please enter the username for the user logs"

        $chkUser = checkuser $name
        if($chkUser -eq $true){ # check if user already exists

            $timeSince = Read-Host -Prompt "enter number of days to search back"
            $userLogins = getLogInAndOffs $timeSince

            Write-Host ($userLogins | Where-Object { $_.User -ilike "*$name"} | Format-Table | Out-String)
        }
        else { Write-Host "user does not exist" | Out-String }
    }

    # get failed login logs
    elseif($choice -eq 8){

        $name = Read-Host -Prompt "Please enter the username for the user's failed login logs"
        
        $chkUser = checkuser $name
        if($chkUser -eq $true){ # check if user already exists
            $timeSince = Read-Host -Prompt "enter number of days to search back"
            $userLogins = getFailedLogins $timeSince
     
           Write-Host ($userLogins | Where-Object { $_.User -ilike "*$name"} | Format-Table | Out-String)
        }
        else { Write-Host "user does not exist" | Out-String }
    }

    # get at risk users, >10 failed logins in time frame
    elseif($choice -eq 9){
        $timeSince = Read-Host -Prompt "enter number of days to search back"
        $atRiskUsers = getAtRiskUsers $timeSince
        Write-Host ($atRiskUsers | Format-Table | Out-String)
    }


    else{
        Write-Host "invalid input: 0-9 allowed`n" | Out-String
    }

