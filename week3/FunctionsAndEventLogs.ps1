# 9/12/24

# 1. Get login and logoff records from Windows Events
#Get-EventLog System -source Microsoft-Windows-Winlogon

# 2. Get login and logoff reords from windows events and save to a variable
#    Get the last 14 days
# 3. Translate SID to Username
# 4. Turn to function with 1 input (number of days)
function getWinLogons ($days){
    $loginouts = Get-EventLog System -source Microsoft-Windows-Winlogon -After (Get-Date).AddDays(-$days)

    $loginoutsTable = @()
    for($i=0; $i -lt $loginouts.Count; $i++){

        # create event property value
        $event = ""
        if($loginouts[$i].InstanceID -eq 7001) {$event="Logon"}
        if($loginouts[$i].InstanceID -eq 7002) {$event="Logoff"}

        # create user property value
        $userSID = New-Object System.Security.Principal.SecurityIdentifier `
        ($loginouts[$i].ReplacementStrings[1])
        $userNAME = $userSID.Translate([System.Security.Principal.NTAccount])

        # add each entry to table
        $loginoutsTable += [pscustomobject]@{"Time" = $loginouts[$i].TimeGenerated; `
                                            "Id" = $loginouts[$i].InstanceId; `
                                            "Event" = $event; `
                                            "User" = $userNAME;                                    
                                            }
    }
    return $loginoutsTable
}

#getWinLogons(30)


# 5. Get shutdown and start events
function getShutdowns ($days){

    $shutdowns = Get-EventLog System -After (Get-Date).AddDays(-$days) | where { $_.EventID -match "600[56]" }

    $shutdownsTable = @()
    for($i=0; $i -lt $shutdowns.Count; $i++){


        # create event property value
        $event = ""
        if($shutdowns[$i].EventID -eq 6006) {$event="Shutdown"}
        if($shutdowns[$i].EventID -eq 6005) {$event="Start"}

        # add each entry to table
        $shutdownsTable += [pscustomobject]@{"Time" = $shutdowns[$i].TimeGenerated; `
                                            "Id" = $shutdowns[$i].EventId; `
                                            "Event" = $event; `
                                            "User" = "SYSTEM";                                    
                                            }
    }
    return $shutdownsTable
}

#getShutdowns

