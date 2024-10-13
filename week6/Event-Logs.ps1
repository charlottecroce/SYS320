. (Join-Path $PSScriptRoot String-Helper.ps1)
. (Join-Path $PSScriptRoot Users.ps1)

<# ******************************
     Function: get event logs from login and logouts
     Input: time back to search
     Output: Array of login/out objects
****************************** #>
function getLogInAndOffs($timeBack){

$loginouts = Get-EventLog system -source Microsoft-Windows-Winlogon -After (Get-Date).AddDays("-"+"$timeBack")

$loginoutsTable = @()
for($i=0; $i -lt $loginouts.Count; $i++){

$type = ""
if($loginouts[$i].InstanceID -eq 7001) {$type="Logon"}
if($loginouts[$i].InstanceID -eq 7002) {$type="Logoff"}


# Check if user exists first
$user = (New-Object System.Security.Principal.SecurityIdentifier `
         $loginouts[$i].ReplacementStrings[1]).Translate([System.Security.Principal.NTAccount])

$loginoutsTable += [pscustomobject]@{"Time" = $loginouts[$i].TimeGenerated; `
                                       "Id" = $loginouts[$i].InstanceId; `
                                    "Event" = $type; `
                                     "User" = $user;
                                     }
} # End of for

return $loginoutsTable
} # End of function getLogInAndOffs




<# ******************************
     Function: get windows event logs for failed logins
     Input: time to search back
     Output: array of failed login objects
****************************** #>
function getFailedLogins($timeBack){
  
  $failedlogins = Get-EventLog security -After (Get-Date).AddDays("-"+"$timeBack") | Where { $_.InstanceID -eq "4625" }

  $failedloginsTable = @()
  for($i=0; $i -lt $failedlogins.Count; $i++){

    $account=""
    $domain="" 

    $usrlines = getMatchingLines $failedlogins[$i].Message "*Account Name*"
    $usr = $usrlines[1].Split(":")[1].trim()

    $dmnlines = getMatchingLines $failedlogins[$i].Message "*Account Domain*"
    $dmn = $dmnlines[1].Split(":")[1].trim()

    $user = $dmn+"\"+$usr;

    $failedloginsTable += [pscustomobject]@{"Time" = $failedlogins[$i].TimeGenerated; `
                                       "Id" = $failedlogins[$i].InstanceId; `
                                    "Event" = "Failed"; `
                                     "User" = $user;
                                     }

    }

    return $failedloginsTable
} # End of function getFailedLogins



<# ******************************************************
   Functions: get at risk users, >10 failed logins in time frame
   Input: time to search back
   Output: array of users & numfailedlogin objects
********************************************************* #>
function getAtRiskUsers($timeBack){
        $users = getEnabledUsers
        $failedLogins = getFailedLogins $timeBack

        $atRiskUsers = @()

        for($i=0; $i -lt $users.Count; $i++){
            $name = $users[$i].Name  
            $failCount = ($failedLogins | Where-Object { $_.User -ilike "*$name"} ).Count
            if($failCount -ge 10){
                $atRiskUsers += [pscustomobject]@{"User" = $name; `
                                                  "Failed Logins" = $failCount; }                  
            }

        }

        return $atRiskUsers

}
