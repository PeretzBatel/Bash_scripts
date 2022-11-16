Connect-AzureRmAccount

#Create new azure storage account
New-AzureRmStorageAccount -StorageAccountName "BatelStorage" -Location 'East US' -ResourceGroupName "DevGroup" -Type Standart_LRS