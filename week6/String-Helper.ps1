<# String-Helper
*************************************************************
   This script contains functions that help with String/Match/Search
   operations. 
************************************************************* 
#>


<# ******************************************************
   Functions: Get Matching Lines
   Input:   1) Text with multiple lines  
            2) Keyword
   Output:  1) Array of lines that contain the keyword
********************************************************* #>
function getMatchingLines($contents, $lookline){

$allines = @()
$splitted =  $contents.split([Environment]::NewLine)

for($j=0; $j -lt $splitted.Count; $j++){  
 
   if($splitted[$j].Length -gt 0){  
        if($splitted[$j] -ilike $lookline){ $allines += $splitted[$j] }
   }

}

return $allines
}

<# ******************************************************
   Functions: Checks if password is >6char, includes a digit, and includes a special character
   Input:   1) Password
   Output:  1) Boolean if password is valid
********************************************************* #>
function checkpassword($passwd){
    Write-Host $passwd
    if($passwd.Length -lt 6){
        Write-Host "failed length test" | Out-String
        return $false
    }
    elseif($passwd -notmatch "[0-9]"){
        Write-Host "Digit Test" | Out-String
        return $false
    }
    elseif($passwd -notmatch "[!$%^@#&().-]"){
        Write-Host "special character test" | Out-String
        return $false
    }else{
        Write-Host "here"
        return $true
    }
}

#checkpassword("abcd123!")