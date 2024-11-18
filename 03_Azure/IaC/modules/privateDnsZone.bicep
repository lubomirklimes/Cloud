param environment string
param location string
param vnetId string

resource privateDnsZone 'Microsoft.Network/privateDnsZones@2024-06-01' = {
  name: '${environment}.privatelink.database.windows.net'
  location: location
  properties: {}
}

resource virtualNetworkLink 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2024-06-01' = {
  name: 'vnetLink-${environment}'
  parent: privateDnsZone
  location: location
  properties: {
    virtualNetwork: {
      id: vnetId
    }
    registrationEnabled: false
  }
}
