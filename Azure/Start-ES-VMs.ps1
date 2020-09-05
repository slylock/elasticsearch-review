try {
    $cred = Get-Credential -UserName "slylock2@mac.com" -Message "Mxxxxxx1" -ErrorAction Ignore
} catch {
    $cred = $null
}
if ($cred -ne $null) {Connect-AzAccount -Credential $cred}
$vms = Get-AzVM  | where {$_.Name -match "Matt-ES"}
$vms | Start-AzVM 