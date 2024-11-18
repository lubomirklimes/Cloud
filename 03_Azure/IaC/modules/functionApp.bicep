param location string
param appName string
param environment string
param appServicePlanId string

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-05-01' = {
  name: toLower('salcs${environment}')
  location: location
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
}

resource functionApp 'Microsoft.Web/sites@2024-04-01' = {
  name: 'func-${appName}'
  location: location
  properties: {
    serverFarmId: appServicePlanId
    siteConfig: {
      appSettings: [
        {
          name: 'AzureWebJobsStorage'
          value: storageAccount.properties.primaryEndpoints.blob
        }
      ]
    }
  }
}

output functionAppId string = functionApp.id
