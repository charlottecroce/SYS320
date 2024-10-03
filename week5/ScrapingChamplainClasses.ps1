function gatherClasses(){

$page = Invoke-WebRequest -TimeoutSec 2 http://localhost/Courses.html

# get all tr elements
$trs=$page.ParsedHTML.body.getElementsByTagName("tr")

# array to hold results
$FullTable = @()
for($i=1; $i -lt $trs.length; $i++){

    # get every td element of current tr element
       $tds= $trs[$i].getElementsByTagName("td")

       # want to seperate start time and end time from one time field
       $Times = $tds[5].innerText.split(" - ")
       
           $FullTable += [pscustomobject]@{"Class Code" = $tds[0].innerText; `
                                            "Title" = $tds[1].innerText; `
                                            "Days" = $tds[4].innerText; `
                                            "Time Start" = $Times[0]; `
                                            "Time End" = $Times[1]; `
                                            "Instructor" = $tds[6].innerText; `
                                            "Location" = $tds[9].innerText; `
                                        }
    }# for loop end
    $Fulltable = daysTranslator($FullTable)
    return $FullTable
}


function daysTranslator($FullTable){

    for($i=0; $i -lt $FullTable.length; $i++){
        $Days = @()

        if($FullTable[$i].Days -ilike "M*"){ $Days += "Monday" }
        if($FullTable[$i].Days -ilike "*T[TWF]*"){ $Days += "Tuesday" }
        if($FullTable[$i].Days -ilike "*W*"){ $Days += "Wednesday" }
        if($FullTable[$i].Days -ilike "*TH*"){ $Days += "Thursday" }
        if($FullTable[$i].Days -ilike "*F*"){ $Days += "Friday" }

        $FullTable[$i].Days = $Days
    }# for loop end
    return $FullTable
}

