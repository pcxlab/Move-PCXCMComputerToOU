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
    PowerShell.exe -NoProfile -ExecutionPolicy Bypass -File MoveToOU.ps1 "OU=Workstations,DC=example,DC=com"
    Moves the current computer to the "Workstations" OU within the "example.com" domain.

.NOTES
    Ensure that you have the necessary permissions to move objects in Active Directory and that the 
    execution policy is set appropriately.

#>

param (
    [string]$OU  # Accept OU as a parameter
)

try {
    # Get the Distinguished Name (DN) of the current computer object
    $CompDN = ([ADSISEARCHER]"sAMAccountName=$($env:COMPUTERNAME)$").FindOne().Path

    # Move the computer object to the specified OU
    $CompObj = [ADSI]"$CompDN"
    $CompObj.psbase.MoveTo([ADSI]"LDAP://$OU")
}
catch {
    Write-Error "Error moving computer object: $_.Exception.Message"
    Exit 1
}
