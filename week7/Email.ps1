﻿
function SendAlertEmail($Body){
$From = "charlotte.croce@mymail.champlain.edu"
$To = "charlotte.croce@mymail.champlain.edu"
$Subject = "Suspicious Activity"

# remove password before publishing to GitHub!
$Password = "fcdh onxc nwzf pday" | ConvertTo-SecureString -AsPlainText -Force
$Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $From, $Password

Send-MailMessage -From $From -To $To -Subject $Subject -Body $Body -SmtpServer "smtp.gmail.com" `
-Port 587 -UseSsl -Credential $Credential

}

#SendAlertEmail "test email body"