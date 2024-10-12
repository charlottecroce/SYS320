. "C:\Users\champuser\SYS320\week6\Event-Logs.ps1"
. "C:\Users\champuser\SYS320\week7\Configuration.ps1"
. "C:\Users\champuser\SYS320\week7\Email.ps1"
. "C:\Users\champuser\SYS320\week7\Scheduler.ps1"

# obtain configuration, from Configurations.ps1
$configuration = readConfiguration

# call atRiskUsers using days obtained from the config file, from Event-logs.ps1
$Failed = getAtRiskUsers $configuration.Days

# sending at risk users as email, from Email.ps1
SendAlertEmail ($Failed | Format-Table | Out-String)

# setting the script to be run daily, from Scheduler.ps1
ChooseTimeToRun($configuration.ExecutionTime)

