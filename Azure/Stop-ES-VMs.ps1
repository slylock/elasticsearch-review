Param ( `
    [Object] $Cred = $null`
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
$vms | Stop-AzVM -Force