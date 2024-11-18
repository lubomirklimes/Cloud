param location string
param environment string

resource vnet 'Microsoft.Network/virtualNetworks@2023-04-01' = {
  name: 'vnet-${environment}'
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: ['10.0.0.0/16']
    }
    subnets: [
      {
        name: 'frontend'
        properties: {
          addressPrefix: '10.0.1.0/24'
        }
      }
      {
        name: 'backend'
        properties: {
          addressPrefix: '10.0.2.0/24'
        }
      }
    ]
  }
}

output vnetId string = vnet.id
output frontendSubnetId string = vnet.properties.subnets[0].id
output backendSubnetId string = vnet.properties.subnets[1].id
output appGatewaySubnetPrefix string = vnet.properties.subnets[0].properties.addressPrefix // Změňte index podle pořadí subnetu
