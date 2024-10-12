#10/12/24

function readConfiguration(){
    Set-Location "C:\Users\champuser\SYS320\week7"
    $configs = (Get-Content -Path ./configuration.txt)
    $days = $configs[0]
    $time = $configs[1]
    return [PSCustomObject]@{
        Days = $days
        ExecutionTime = $time
    }
}

function changeConfiguration(){
    $daysBack = Read-Host -Prompt "Number of days for which the logs will be obtained"
    if($daysBack -notmatch '^[0-9]+$'){
        Write-Host "invalid input. digits only" | Out-String
        continue
    }
     
    $executionTime = Read-Host -Prompt "Daily execution time of the script"
    if($executionTime -inotmatch '^(1?[1-9]):([0-5][0-9])\s(AM|PM)$'){
        Write-Host "invalid input. digit:digitdigit am/pm allowed" | Out-String
        continue
    }

    "$daysBack`n$executionTime" | Set-Content ./configuration.txt
    Write-Host "Configuration Changed`n" | Out-String
}

#main loop
function configurationMenu(){
    clear

    $Prompt  = "`nPlease choose your operation:`n"
    $Prompt += "1 - Show Configuration`n"
    $Prompt += "2 - Change Configuration`n"
    $Prompt += "3 - Exit`n"

    $operation = $true

    while($operation){

    
    Write-Host $Prompt | Out-String
    $choice = Read-Host 

    # exit
    if($choice -eq 3){
        Write-Host "Goodbye" | Out-String
        exit
        $operation = $false 
    }

    # show configuration
    elseif($choice -eq 1){
        $config = readConfiguration
        $config
    }

    # change configuration
    elseif($choice -eq 2){
        changeConfiguration
    }

    else{
        Write-Host "invalid input: 1-3 allowed`n" | Out-String
    }
}
}



#configurationMenu