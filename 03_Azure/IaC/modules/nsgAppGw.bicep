param location string
param environment string

resource nsgAppGw 'Microsoft.Network/networkSecurityGroups@2023-04-01' = {
  name: 'nsg-appGateway-${environment}'
  location: location
  properties: {
    securityRules: [
      {
        name: 'AllowHttps'
        properties: {
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '443'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 100
          direction: 'Inbound'
        }
      }
    ]
  }
}

output nsgId string = nsgAppGw.id
