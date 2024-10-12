# 9/5/24

# Part 1 - Networking

# 1. Get IPv4 address from eth int
(Get-NetIPAddress -AddressFamily IPv4 | `
Where-Object { $_.InterfaceAlias -ilike "Ethernet0" }).IPAddress

# 2. Get prefix length from eth int
(Get-NetIPAddress -AddressFamily IPv4 | `
Where-Object { $_.InterfaceAlias -ilike "Ethernet0" }).PrefixLength

# 3. Show what classes in Win32 library start with net
Get-WmiObject -List | Where-Object { $_.Name -ilike "Win32_Net*" }

# 4. ...and sort alphabetically
Get-WmiObject -List | Where-Object { $_.Name -ilike "Win32_Net*" } | Sort-Object

# 5. Get DHCP server IP
Get-CimInstance Win32_NetworkAdapterConfiguration -Filter "DHCPEnabled=$true" | Select DHCPServer

# 6. ...and hide table headers
Get-CimInstance Win32_NetworkAdapterConfiguration -Filter "DHCPEnabled=$true" | `
Select DHCPServer | Format-Table -HideTableHeaders

# 7. Get DNS server IP for eth int and only display first result
(Get-DnsClientServerAddress -AddressFamily IPv4 | `
Where-Object { $_.InterfaceAlias -ilike "Ethernet0" }).ServerAddresses[0]

# Part 2 - Directory Listings

# 8. List all files in working directory that have extension .ps1
$files=(Get-ChildItem)
for ($j=0; $j -le $files.Length; $j++){
    if ($files[$j].Name -ilike "*ps1"){
        Write-Host $files[$j].Name
    }
}

# 9. Create a folder called "outfolder" if it does not already exist
$folderpath="$PWD\outfolder"
if (Test-Path $folderpath){
    Write-Host "Folder Already Exists"
}
else{
    New-Item -ItemType "directory" -Path "$folderpath"
}

# 10. List all files in working directory that have extension .ps1
#     and save results to out.csv file in outfolder directory
$files=(Get-ChildItem)
$folderpath="$PWD\outfolder"
$filepath = Join-Path $folderpath "out.csv"
$files | Where-Object {$_.Extension -eq ".ps1" } | `
Export-Csv -Path $filepath

# 11. Without changing directory, find every .csv file and change their extensions to .log, 
#     then recursively display all the files
$files = Get-ChildItem -File -Recurse
$files | Rename-Item -NewName { $_.Name -replace '.csv', '.log' }
Get-ChildItem -Recurse

