@description('Tagging for the resources.')
param code string
param owner string
param costCenter string
@description('Define Azure Files parmeters')
param storageaccountlocation string
param storageaccountName string = 'avdsa${uniqueString(resourceGroup().id)}'
param storageaccountkind string
param storgeaccountglobalRedundancy string = 'Premium_LRS'
param fileshareFolderName string = 'profilecontainers'

// Create Storage account
resource sa 'Microsoft.Storage/storageAccounts@2020-08-01-preview' = {
  name: storageaccountName
  location: storageaccountlocation
  kind: storageaccountkind
  tags:{
    Codeversion: code
    Owner: owner
    Costcenter:costCenter
  }
  sku: {
    name: storgeaccountglobalRedundancy
  }
}

// Concat FileShare
var filesharelocation = '${sa.name}/default/${fileshareFolderName}'

// Create FileShare
resource fs 'Microsoft.Storage/storageAccounts/fileServices/shares@2020-08-01-preview' = {
  name: filesharelocation
}

output storageAccountId string = sa.id
