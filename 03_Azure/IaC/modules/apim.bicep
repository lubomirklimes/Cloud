param location string
param appName string

resource apim 'Microsoft.ApiManagement/service@2024-05-01' = {
  name: 'apim-${appName}'
  location: location
  sku: {
    name: 'Developer'
    capacity: 1
  }
  properties: {
    publisherEmail: 'admin@example.com'
    publisherName: 'My Company'
  }
}
