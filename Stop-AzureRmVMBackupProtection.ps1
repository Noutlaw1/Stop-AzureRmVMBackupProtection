function Stop-AzureRmVMBackupProtection {
[CmdletBinding()]
    PARAM(
        [parameter(Mandatory=$true)]
        [STRING]$ResourceGroupName,
        [parameter(Mandatory=$true)]
        [STRING]$RecoveryVaultName,
        [parameter(Mandatory=$true)]
        [STRING]$VMName,
        [parameter(Mandatory=$false)]
        [BOOLEAN]$Remove_RecoveryPoints)
    PROCESS
    {
        $Vault = Get-AzureRmRecoveryServicesVault -ResourceGroupName $ResourceGroupName -Name $RecoveryVaultName
        $vault | Set-AzureRmRecoveryServicesVaultContext
        $BackupContainers = $Containers = Get-AzureRmRecoveryServicesBackupContainer -ContainerType "AzureVM" -BackupManagementType "AzureVM"
        $BackupContainers
        $VMContainer = $BackupContainers | where {$_.FriendlyName -LIKE $VMName}
        $VmContainer
        $BackupItem = Get-AzureRmRecoveryServicesBackupItem -Container $VMContainer -WorkloadType "AzureVM"
        if ($Remove_RecoveryPoints -ne $true)
        {
            Disable-AzureRmREcoveryServicesBackupProtection -Item $BackupItem | Out-Null
        }
        else
        {
            Disable-AzureRmREcoveryServicesBackupProtection -Item $BackupItem -RemoveRecoveryPoints | Out-Null
        }
    return $true
    }
}
