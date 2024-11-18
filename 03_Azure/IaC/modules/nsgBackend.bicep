param location string
param environment string
param appGatewaySubnetCidr string

resource nsgBackend 'Microsoft.Network/networkSecurityGroups@2023-04-01' = {
  name: 'nsg-backend-${environment}'
  location: location
  properties: {
    securityRules: [
      {
        name: 'AllowFromAppGateway'
        properties: {
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '80'
          sourceAddressPrefix: appGatewaySubnetCidr
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 100
          direction: 'Inbound'
        }
      }
    ]
  }
}
