$ProgressPreference = 'SilentlyContinue'
chcp 65001

function hvcli-List-VMs(){
    Get-VM | Select Name, VMId | ConvertTo-Json
    If($? -ne $True){
        exit 1
    }
}

function hvcli-Describe-VM([string]$vm_name, [string]$vm_id){
    If($vm_name){
        $VM = Get-VM -Name "$vm_name"
    }
    Else{
        $VM = Get-VM -Id "$vm_id"
    }
    $VM  | Select * | ConvertTo-Json
    If($? -ne $True){
        exit 1
    }
}

function hvcli-Stop-VM([string]$vm_name, [string]$vm_id){
    If($vm_name){
        $VM = Stop-VM -Name "$vm_name"
    }
    Else{
        $VM = Get-VM -Id "$vm_id"
    }
    Stop-VM -VM $VM @args
    If($? -ne $True){
        exit 1
    }
}

function hvcli-Start-VM([string]$vm_name, [string]$vm_id){
    If($vm_name){
        $VM = Get-VM -Name "$vm_name"
    }
    Else{
        $VM = Get-VM -Id "$vm_id"
    }
    Start-VM -VM $VM
    If($? -ne $True){
        exit 1
    }
}

function hvcli-Restart-VM([string]$vm_name, [string]$vm_id){
    If($vm_name){
        $VM = Get-VM -Name "$vm_name"
    }
    Else{
        $VM = Get-VM -Id "$vm_id"
    }
    Restart-VM -VM $VM -Force
    If($? -ne $True){
        exit 1
    }
}

function hvcli-Reboot-VM([string]$vm_name, [string]$vm_id){
    If($vm_name){
        $VM = Get-VM -Name "$vm_name"
    }
    Else
    {
        $VM = Get-VM -Id "$vm_id"
    }
    Stop-VM -VM $VM
    While($VM.State -ne "Off"){
        Start-Sleep 1
    }
    Start-VM -VM $VM
    If($? -ne $True){
        exit 1
    }
}

function hvcli-Get-VM-Status([string]$vm_name, [string]$vm_id){
    If($vm_name){
        $VM = Get-VM -Name "$vm_name"
    }
    Else
    {
        $VM = Get-VM -Id "$vm_id"
    }
    $ConvertStateToString=@{Label="StateName"; Expression={[String]$_.State}}
    $VM | Select VMName, VMId, State, $ConvertStateToString, PrimaryStatusDescription | ConvertTo-Json
    If($? -ne $True){
        exit 1
    }
}

function hvcli-Get-VM-Memory([string]$vm_name, [string]$vm_id){
    If($vm_name){
        $VM = Get-VM -Name "$vm_name"
    }
    Else
    {
        $VM = Get-VM -Id "$vm_id"
    }
    Get-VMMemory -VM $VM | Select Startup, DynamicMemoryEnabled, Minimum, Maximum, Buffer, Priority | ConvertTo-Json
    If($? -ne $True){
        exit 1
    }
}

function hvcli-Set-VM-Memory([string]$vm_name, [string]$vm_id){
    If($vm_name){
        $VM = Get-VM -Name "$vm_name"
    }
    Else
    {
        $VM = Get-VM -Id "$vm_id"
    }
    Set-VMMemory -VM $VM @args
    If($? -ne $True){
        exit 1
    }
}

# End of collection. DO NOT DELETE THE LINE BELOW
