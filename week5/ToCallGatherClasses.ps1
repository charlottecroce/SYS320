(Join-Path $PSScriptRoot .\ScrapingChamplainClasses.ps1)

$Fulltable = gatherClasses

# i. all classes taught by Furkan Paligu
#$Fulltable | select "Class Code", Instructor, Location, Days, "Time Start", "Time End" `
#| where { $_."Instructor" -ilike "Furkan Paligu" }

# ii. list all classes in JOYC 310 on Mondays, display class code and times, sort by start time
#$Fulltable | Where-Object { ($_."Location" -ilike "JOYC 310") -and ($_.days -contains "Monday")} | `
#Sort-Object "Time Start" | `
#Select-Object "Time Start", "Time End", "Class Code"

# iii. create list of all instructors that teach at least one course in SYS, NET, SEC, FOR, CSI, DAT.
# sort by name and make it unique

$ITSInstrucotrs = $Fulltable | Where-Object { ($_."Class Code" -ilike "SYS*") -or `
                                              ($_."Class Code" -ilike "NET*") -or `
                                              ($_."Class Code" -ilike "SEC*") -or `
                                              ($_."Class Code" -ilike "FOR*") -or `
                                              ($_."Class Code" -ilike "CSI*") -or `
                                              ($_."Class Code" -ilike "DAT*") } `
                                              | Sort-Object "Instructor" `
                                              | Select-Object "Instructor" -Unique


# iv. group instructors by number of classes they are teaching
# sort by num classes teaching
$FullTable | Where { $_.Instructor -in $ITSInstrucotrs.Instructor } `
    | Group-Object "Instructor" | Select-Object Count,Name | Sort-Object Count -Descending
