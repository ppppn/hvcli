$ProgressPreference = 'SilentlyContinue'
chcp 65001 # Do not redirect to Out-Object, otherwise, chcp won't work. (Why?)

function hvcli-List-VM-NetworkAdapters([string]$vm_name, [string]$vm_id){
    If($vm_name){
        $VM = Get-VM -Name "$vm_name"
    }
    Else
    {
        $VM = Get-VM -Id "$vm_id"
    }
    $VM | Get-VMNetworkAdapter | Select Name, MacAddress, SwitchName | ConvertTo-Json

    If($? -ne $True){
        exit 1
    }
}

function hvcli-Describe-VM-NetworkAdapter([string]$vm_name, [string]$vm_id, [string]$macaddress){
    If($vm_name){
        $VM = Get-VM -Name "$vm_name"
    }
    Else
    {
        $VM = Get-VM -Id "$vm_id"
    }
    $VM | Get-VMNetworkAdapter | Where MacAddress -eq $macaddress | ConvertTo-Json

    If($? -ne $True){
        exit 1
    }
}

function hvcli-Rename-VM-NetworkAdapter([string]$vm_name, [string]$vm_id, [string]$macaddress, [string]$newname){
    If($vm_name){
        $VM = Get-VM -Name "$vm_name"
    }
    Else
    {
        $VM = Get-VM -Id "$vm_id"
    }
    $NetworkAdapter = $VM | Get-VMNetworkAdapter | Where MacAddress -eq $macaddress
    $NetworkAdapter | Rename-VMNetworkAdapter -NewName $newname

    If($? -ne $True){
        exit 1
    }
}

# End of collection. DO NOT DELETE THE LINE BELOW
