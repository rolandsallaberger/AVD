<#
.SYNOPSIS
    Used as a custom script extension for running BISF on Windows VM's in Azure
.DESCRIPTION
    
.NOTES
   
.LINK
#>


#Script to run BISF on a VM
#Logging is handy when you need it!
if ((test-path c:\logfiles) -eq $false) {
    new-item -ItemType Directory -path 'c:\' -name 'logfiles' | Out-Null
} 
$logFile = "c:\logfiles\" + (get-date -format 'yyyyMMdd') + '_softwareinstall.log'

# Logging function
function Write-Log {
    Param($message)
    Write-Output "$(get-date -format 'yyyyMMdd HH:mm:ss') $message" | Out-File -Encoding utf8 $logFile -Append
}
#Run Sysprep
try{
    write-output "BIS-F Starting"
    Start-Process -filepath 'c:\tools\preparation.cmd' -ErrorAction Stop
}
catch {
    $ErrorMessage = $_.Exception.message
    write-log "Error running BIS-F: $ErrorMessage"
}
