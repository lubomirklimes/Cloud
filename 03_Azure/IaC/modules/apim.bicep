param location string
param apimName string
param publisherEmail string
param publisherName string
param skuName string
param skuCapacity int

resource apim 'Microsoft.ApiManagement/service@2024-05-01' = {
  name: apimName
  location: location
  properties: {
    publisherEmail: publisherEmail
    publisherName: publisherName
  }
  sku: {
    name: skuName
    capacity: skuCapacity
  }
}

output apimGatewayUrl string = apim.properties.gatewayUrl
