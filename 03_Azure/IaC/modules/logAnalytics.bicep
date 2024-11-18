param location string
param environment string

resource workspace 'Microsoft.OperationalInsights/workspaces@2023-09-01' = {
  name: 'logAnalytics-${environment}'
  location: location
  properties: {
    sku: {
      name: 'PerGB2018'
    }
  }
}

output workspaceId string = workspace.id
