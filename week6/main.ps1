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


    if($choice -eq 0){
        Write-Host "Goodbye" | Out-String
        exit
        $operation = $false 
    }

    elseif($choice -eq 1){
        $enabledUsers = getEnabledUsers
        Write-Host ($enabledUsers | Format-Table | Out-String)
    }

    elseif($choice -eq 2){
        $notEnabledUsers = getNotEnabledUsers
        Write-Host ($notEnabledUsers | Format-Table | Out-String)
    }

    
        # DONE: Create a function called checkUser in Users that: 
        #              - Checks if user a exists. 
        #              - If user exists, returns true, else returns false
        # DONE: Check the given username with your new function.
        #              - If false is returned, continue with the rest of the function
        #              - If true is returned, do not continue and inform the user
        #
        # DONE: Create a function called checkPassword in String-Helper that:
        #              - Checks if the given string is at least 6 characters
        #              - Checks if the given string contains at least 1 special character, 1 number, and 1 letter
        #              - If the given string does not satisfy conditions, returns false
        #              - If the given string satisfy the conditions, returns true
        # DONE: Check the given password with your new function. 
        #              - If false is returned, do not continue and inform the user
        #              - If true is returned, continue with the rest of the function


    # Create a user
    elseif($choice -eq 3){ 

        $name = Read-Host -Prompt "Please enter the username for the new user"
        
        $chkuser = checkuser $name
        if($chkuser -ne $true){        
        
        $password = Read-Host -AsSecureString -Prompt "Please enter the password for the new user"
        $bstr = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($password)
        $plainpassword = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($bstr)

        $chkPasswd = checkpassword $plainpassword

        if($chkPasswd -ne $false){
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

        # DONE: Check the given username with the checkUser function.
        $chkUser = checkuser $name
        if($chkUser -eq $true){
        removeAUser $name

        Write-Host "User: $name Removed." | Out-String
        }
        else { Write-Host "user does not exist" | Out-String }
    }


    # Enable a user
    elseif($choice -eq 5){


        $name = Read-Host -Prompt "Please enter the username for the user to be enabled"

        # DONE: Check the given username with the checkUser function.

        $chkUser = checkuser $name
        
        if($chkUser -eq $true){
            enableAUser $name
            Write-Host "User: $name Enabled." | Out-String
        }
        else { Write-Host "user does not exist" | Out-String }

    }


    # Disable a user
    elseif($choice -eq 6){

        $name = Read-Host -Prompt "Please enter the username for the user to be disabled"

        # DONE: Check the given username with the checkUser function.

        $chkUser = checkuser $name
        if($chkUser -eq $true){
            disableAUser $name
            Write-Host "User: $name Disabled." | Out-String
        }
        else{ Write-Host "user does not exist" | Out-String }
    }


    elseif($choice -eq 7){

        $name = Read-Host -Prompt "Please enter the username for the user logs"

        # DONE: Check the given username with the checkUser function.

        $chkUser = checkuser $name
        if($chkUser -eq $true){


        $timeSince = Read-Host -Prompt "enter number of days to search back"
        $userLogins = getLogInAndOffs $timeSince
        # DONE: Change the above line in a way that, the days 90 should be taken from the user

        Write-Host ($userLogins | Where-Object { $_.User -ilike "*$name"} | Format-Table | Out-String)
        }
        else { Write-Host "user does not exist" | Out-String }
    }


    elseif($choice -eq 8){

        $name = Read-Host -Prompt "Please enter the username for the user's failed login logs"

        # DONE: Check the given username with the checkUser function.
        
        $chkUser = checkuser $name
        if($chkUser -eq $true){
        $timeSince = Read-Host -Prompt "enter number of days to search back"
        $userLogins = getFailedLogins $timeSince
        # DONE: Change the above line in a way that, the days 90 should be taken from the user

        Write-Host ($userLogins | Where-Object { $_.User -ilike "*$name"} | Format-Table | Out-String)
        }
        else { Write-Host "user does not exist" | Out-String }
    }

    # get at risk users, >10 failed logins in time frame
    elseif($choice -eq 9){
       
        $timeSince = Read-Host -Prompt "enter number of days to search back"
      
        $atRiskUsers = getAtRiskUsers $timeSince
        # DONE: Change the above line in a way that, the days 90 should be taken from the user

        Write-Host ($atRiskUsers | Format-Table | Out-String)
    
    }


    else{
        Write-Host "invalid input: 0-9 allowed`n"
    }

    # DONE: Create another choice "List at Risk Users" that
    #              - Lists all the users with more than 10 failed logins in the last <User Given> days.  
    #                (You might need to create some failed logins to test)
    #              - Do not forget to update prompt and option numbers
    
    # DONE: If user enters anything other than listed choices, e.g. a number that is not in the menu   
    #       or a character that should not be accepted. Give a proper message to the user and prompt again.
    

}




