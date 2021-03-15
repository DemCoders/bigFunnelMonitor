C:\dev\Connect-ExchangeOnPrem.ps1
$mbxCount = get-mailbox *2
New-Item C:\dev\BigFunnelMonitor\BFM.csv -Type file -Force
$logFile = "C:\dev\BigFunnelMonitor\BFM.csv"

write-host -ForegroundColor yellow "Creating log file" $logFile
"Time"+","+"DisplayName"+","+"BigFunnelNotIndexedCount"+","+"BigFunnelShouldNotBeIndexedCount"+","+`
"BigFunnelMessageCount"+","+"BigFunnelStaleCount"+","+"BigFunnelFilterTableTotalSize(KB)" | Add-Content $logFile
$i = 0
write-host -ForegroundColor yellow "adding data to " $logFile

do{

$i++

$mbxCount | % {

$dateRun= get-date -Format "ddd_MM_HH:mm:ss"
$stats = Get-MailboxStatistics $_.alias 
$bfs = $stats.BigFunnelFilterTableAvailableSize.value.ToString().split("(").replace(",","").split(" ")[0]
$dateRun +","+ $stats.DisplayName+","+$stats.BigFunnelNotIndexedCount+","+$stats.BigFunnelShouldNotBeIndexedCount`
+","+$stats.BigFunnelMessageCount+","+$stats.BigFunnelStaleCount+","+$bfs | Add-Content $logFile 
$dateRun +","+ $stats.DisplayName+","+$stats.BigFunnelNotIndexedCount+","+$stats.BigFunnelShouldNotBeIndexedCount`
+","+$stats.BigFunnelMessageCount+","+$stats.BigFunnelStaleCount+","+$bfs 

}

$Start = get-date -Format "ddd_MM_HH:mm:ss"
$restart = (get-date).AddMinutes(5)
write-host -ForegroundColor green "started previously at: $end.  Sleeping at: $Start.  Restarting at: $restart "
sleep 300
$end = get-date -Format "ddd_MM_HH:mm:ss"
write-host -ForegroundColor yellow "restarting at: $end"
}
until(($i -eq 100000000) -eq $true )