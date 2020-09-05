Param ( `
    [Object] $VM =$null`
)
if ($vm -eq $null) {Write-Error "Single VM required"}
$nics = Get-AzNetworkInterface | where {$_.Id -eq $vm.NetworkProfile.NetworkInterfaces.Id}
foreach ($nic in $nics) {
    foreach ($config in $nic.IpConfigurations) {
        $config.PrivateIpAddress
    }
}
