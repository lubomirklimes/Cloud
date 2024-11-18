param environment string
param vnetId string

resource dnsZone 'Microsoft.Network/privateDnsZones@2024-06-01' = {
  name: 'privatelink.${environment}.azure.local'
  location: 'westeurope'
  properties: {}
}

resource dnsLink 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2024-06-01' = {
  name: 'dnsLink-${environment}'
  parent: dnsZone
  properties: {
    virtualNetwork: {
      id: vnetId
    }
  }
}
