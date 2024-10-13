# sends an email to charlotte.croce@mymail.champlain.edu
# with one parameter for the email body
function SendAlertEmail($Body){
$From = "charlotte.croce@mymail.champlain.edu"
$To = "charlotte.croce@mymail.champlain.edu"
$Subject = "Suspicious Activity"

# remove password before publishing to GitHub!
# ...and if you accidentally push with the password visible, just delete the appKey
$Password = "insert-new-appkey-here" | ConvertTo-SecureString -AsPlainText -Force
$Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $From, $Password

Send-MailMessage -From $From -To $To -Subject $Subject -Body $Body -SmtpServer "smtp.gmail.com" `
-Port 587 -UseSsl -Credential $Credential

}

#SendAlertEmail "test email body"