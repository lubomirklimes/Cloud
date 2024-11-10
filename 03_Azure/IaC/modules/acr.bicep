param location string
param acrName string
param sku string

resource acr 'Microsoft.ContainerRegistry/registries@2023-07-01' = {
  name: acrName
  location: location
  sku: {
    name: sku
  }
}

output acrLoginServer string = acr.properties.loginServer
