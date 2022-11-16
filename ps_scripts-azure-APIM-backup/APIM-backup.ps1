Connect-AzureRmAccount

#Create new azure storage account
New-AzureRmStorageAccount -StorageAccountName "BatelStorage" -Location 'East US' -ResourceGroupName "DevGroup" -Type Standart_LRS
#Storage Key
$storageKey = (Get-AzureRmStorageAccountKey -ResourceGroupName "DevGroup" -StorageAccountName "BatelStorage")[0].Value