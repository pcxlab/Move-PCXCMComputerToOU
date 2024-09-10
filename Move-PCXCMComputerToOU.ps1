<#
.SYNOPSIS
    Moves the current computer object in Active Directory (AD) to a specified Organizational Unit (OU).

.DESCRIPTION
    This script retrieves the Distinguished Name (DN) of the computer object in Active Directory
    and moves it to the OU provided as a parameter. This is useful for automating the process of 
    relocating computer objects in AD based on specified OUs.

.PARAMETER OU
    The Distinguished Name (DN) of the target Organizational Unit (OU) where the computer object should be moved.

.EXAMPLE
    PowerShell.exe -NoProfile -ExecutionPolicy Bypass -File MoveToOU.ps1 "OU=Workstations,DC=PCXLab,DC=com"
    Moves the current computer to the "Workstations" OU within the "PCXLab.com" domain.

.NOTES
    Ensure that you have the necessary permissions to move objects in Active Directory and that the 
    execution policy is set appropriately.

#>

param (
    [string]$OU = "OU=DefaultOU,DC=corp,DC=pcxlab,DC=com"  # Set a default OU if not supplied
)

# Define log folder and file location
$logFolder = "C:\Logs"
$logFile = "$logFolder\MoveToOU_$($env:COMPUTERNAME)_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"

# Ensure the log folder exists; if not, create it
if (-not (Test-Path -Path $logFolder)) {
    New-Item -Path $logFolder -ItemType Directory | Out-Null
}

# Function to log messages
function Log-Message {
    param (
        [string]$Message,
        [string]$Level = "INFO"
    )
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $logEntry = "$timestamp [$Level] - $Message"
    Add-Content -Path $logFile -Value $logEntry
}

# Start logging
Log-Message "Script started."

try {
    # Get the Distinguished Name (DN) of the current computer object
    $CompDN = ([ADSISEARCHER]"sAMAccountName=$($env:COMPUTERNAME)$").FindOne().Path
    Log-Message "Found computer object: $CompDN."

    # Move the computer object to the specified OU
    $CompObj = [ADSI]"$CompDN"
    $CompObj.psbase.MoveTo([ADSI]"LDAP://$OU")
    Log-Message "Successfully moved computer to OU: $OU."

    # Verify the new location of the computer object
    $NewCompDN = ([ADSISEARCHER]"sAMAccountName=$($env:COMPUTERNAME)$").FindOne().Path
    Log-Message "Computer object new DN after move: $NewCompDN."

    # Check if the computer is now in the specified OU
    if ($NewCompDN -like "*$OU*") {
        Log-Message "Computer has been successfully moved to the OU: $OU."
    } else {
        Log-Message "Warning: Computer does not appear to be in the specified OU: $OU." "WARNING"
    }
}
catch {
    # Log error message
    Log-Message "Error moving computer object: $_.Exception.Message" "ERROR"
    Exit 1
}
finally {
    # End logging
    Log-Message "Script finished."
}
