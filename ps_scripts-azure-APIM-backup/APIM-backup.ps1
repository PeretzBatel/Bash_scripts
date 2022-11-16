Connect-AzureRmAccount

#Create new azure storage account
New-AzureRmStorageAccount -StorageAccountName "BatelStorage" -Location 'East US' -ResourceGroupName "DevGroup" -Type Standart_LRS
#Storage Key
$storageKey = (Get-AzureRmStorageAccountKey -ResourceGroupName "DevGroup" -StorageAccountName "BatelStorage")[0].Value
#Storge Context
$storgeContext = NewAzureStorageContext -StorageAccountName "BatelStorage" -AzureRmStorageAccountKey $storageKey
#Creating New container in the existing storge account - The container will host APIM backup-blob
New-AzureStorageContainer -Name "apimbackupscontainer" -Permissiom Off -Context $storgeContext
#Create BackUp
Backup-AzureApiManagment -ResourceGroupName "DevGroup" -Name "APIM-BACKUP-DEMO-02" -storgeContext $storgeContext -TargetContainerName "apimbackupscontainer" -TargetBlobName "apimbackups01.BatelStorage"