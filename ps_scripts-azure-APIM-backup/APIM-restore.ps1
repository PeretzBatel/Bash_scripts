Connect AzureRmAccount

#Creating new instance
New-AzureRmApiManagement -ResourceGroupName "DevGroup" -Name "Restored-APIM-BACKUP-DEMO-02" -Location 'Eest US' -Organization "BatelOrganization" -AdminEmail "Admin@outlook.com"
$storageKey = (Get-AzureRmStorageAccountKey -ResourceGroupName "DevGroup" -StorageAccountName "BatelStorage")[0].Value
$storgeContext = NewAzureStorageContext -StorageAccountName "BatelStorage" -AzureRmStorageAccountKey $storageKey
Restore-AzureRmApiManagement -ResourceGroupName "DevGroup" -Name "Restored-APIM-BACKUP-DEMO-02" -StorageContext $storgeContext -SourceContainerName "apimbackupscontainer" -SourceBlobName "apimbackupscontainer.apimdemobackups01"