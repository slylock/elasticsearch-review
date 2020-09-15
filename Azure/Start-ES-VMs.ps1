Param ( `
    [Object] $Cred = $null,`
    [Switch] $RebootVMs = $true `
)
if ((Get-InstalledModule -Name Az -ErrorAction Ignore)  -eq $null) {
    throw "Az modeule required"
    #Install-Module -Name Az -AllowClobber
}

if ($Cred -eq $null) {
    try {
        $Cred = Get-Credential -UserName "slylock2@mac.com" -Message "Mxxxxxx1" -ErrorAction Ignore
    } catch {
        $Cred = $null
    }
}
if ($Cred -ne $null) {Connect-AzAccount -Credential $Cred}

$vms = Get-AzVM  | where {$_.Name -match "Matt-ES"}
$vms | Start-AzVM -NoWait

$waiting = $true
while ($waiting) {
    $waiting = $false
    $vms = Get-AzVM  | where {$_.Name -match "Matt-ES"}
    $vms | Format-Table
    foreach ($vm in $vms) {
        if ($vm.ProvisioningState -ne "Succeeded") {$waiting = $true}
    }
    Start-Sleep -Seconds 10
}

if ($RebootVMs) {
Write-Host "Restarting 1-3..."
$vms[0..2] | Restart-AzVM
}

