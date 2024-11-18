param location string
param environment string
param targetResourceId string
param subnetId string

resource privateEndpoint 'Microsoft.Network/privateEndpoints@2023-04-01' = {
  name: 'privateEndpoint-${environment}'
  location: location
  properties: {
    subnet: {
      id: subnetId
    }
    privateLinkServiceConnections: [
      {
        name: 'privateConnection'
        properties: {
          privateLinkServiceId: targetResourceId
          groupIds: [
            'sites' // Specifikujte správnou groupId (např. "sites" pro App Service)
          ]
        }
      }
    ]
  }
}
