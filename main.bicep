targetScope = 'subscription'

@description('Tagging for the resources.')
param code string = 'am v0.2'
param owner string = 'antti.makkonen@testi.fi'
param costCenter string = 'tuotanto'
@description('Define AVD deployment parameters')
param resourceGroupPrefix string = 'PWS-GITTEST-RG-'

@description('Define Azure Files deployment parameters')
param storageaccountkind string = 'FileStorage'
param storgeaccountglobalRedundancy string = 'Premium_LRS'
param fileshareFolderName string = 'profilecontainers'

@description('Location for resources')
param location4all string = 'westeurope'

//Create Resource Groups
resource rgstorage 'Microsoft.Resources/resourceGroups@2020-06-01' = {
  name: '${resourceGroupPrefix}STORAGE'
  location: location4all
  tags:{
    Codeversion: code
    Owner: owner
    Costcenter:costCenter
  }
}

//Create avd Azure File Services and FileShare`
module avdFileServices './create-stg-acc.bicep' = {
  name: 'avdFileServices'
  scope: rgstorage
  params: {
    code: code
    owner: owner
    costCenter:costCenter
    storageaccountlocation: location4all
    storageaccountkind: storageaccountkind
    storgeaccountglobalRedundancy: storgeaccountglobalRedundancy
    fileshareFolderName: fileshareFolderName
  }
}
