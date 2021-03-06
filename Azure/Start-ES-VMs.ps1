<#
.Synopsis
   Start VMs in Azure
.DESCRIPTION
   Start VMs in Azure
.EXAMPLE
    .\Start-ES-VMs.ps1 -Credential $cred -Pattern 'Matt' -Government
    .\Start-ES-VMs.ps1 -UserName "slylock2@mac.com" -Pattern 'Matt-ES-4' -LoginMessage "Mxxxxxx1"
#>

Param ( `
    [Object] $Credential = $null,`
	$UserName = "", `
    $Pattern = "", `
    $LoginMessage = "Enter credentials for Azure", `
    [Switch] $Government = $false, `
    [Switch] $RebootVMs = $false `
)
if ((Get-InstalledModule -Name Az -ErrorAction Ignore)  -eq $null) {
    throw "Az modeule required"
    #Install-Module -Name Az -AllowClobber
}

if ($Pattern -eq "") {
    throw "Pattern for VM Names required"
}

if ($Credential -eq $null) {
    try { $Credential = Get-Credential -UserName $UserName -Message $LoginMessage -ErrorAction Ignore
    } catch {
        $Credential = $null
    }
}
if ($Credential -ne $null) {
	if ($Government) {
		Connect-AzAccount -Credential $Credential -Environment AzureUSGovernment
	} else {
		Connect-AzAccount -Credential $Credential
	}
}

$vms = Get-AzVM  | where {$_.Name -match $Pattern}
$vms | Start-AzVM -NoWait

$waiting = $true
while ($waiting) {
    $waiting = $false
    $vms = Get-AzVM  | where {$_.Name -match $Pattern}
    $vms | Format-Table
    foreach ($vm in $vms) {
        if ($vm.ProvisioningState -ne "Succeeded") {$waiting = $true}
    }
    Start-Sleep -Seconds 20
}

if ($RebootVMs) {
Write-Host "Restarting 1-3..."
$vms[0..2] | Restart-AzVM
}

