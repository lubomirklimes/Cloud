param location string
param environment string
param subnetId string

resource publicIp 'Microsoft.Network/publicIPAddresses@2023-04-01' = {
  name: 'appGatewayPublicIp-${environment}'
  location: location
  sku: {
    name: 'Standard'
  }
  properties: {
    publicIPAllocationMethod: 'Static'
  }
}

resource appGateway 'Microsoft.Network/applicationGateways@2023-04-01' = {
  name: 'appGateway-${environment}'
  location: location
  properties: {
    sku: {
      name: 'WAF_v2'
      tier: 'WAF_v2'
      capacity: 2
    }
    gatewayIPConfigurations: [
      {
        name: 'appGatewayIpConfig'
        properties: {
          subnet: {
            id: subnetId
          }
        }
      }
    ]
    frontendIPConfigurations: [
      {
        name: 'frontendConfig'
        properties: {
          publicIPAddress: {
            id: publicIp.id
          }
        }
      }
    ]
    frontendPorts: [
      {
        name: 'frontendPort'
        properties: {
          port: 443
        }
      }
    ]
    backendAddressPools: [
      {
        name: 'backendPool'
        properties: {
          backendAddresses: [
            {
              fqdn: 'my-backend-${environment}.azurewebsites.net'
            }
          ]
        }
      }
    ]
    httpListeners: [
      {
        name: 'httpListener'
        properties: {
          frontendIPConfiguration: {
            id: resourceId('Microsoft.Network/applicationGateways/frontendIPConfigurations', 'appGateway-${environment}', 'frontendConfig')
          }
          frontendPort: {
            id: resourceId('Microsoft.Network/applicationGateways/frontendPorts', 'appGateway-${environment}', 'frontendPort')
          }
          protocol: 'Https'
        }
      }
    ]
    requestRoutingRules: [
      {
        name: 'defaultRoutingRule'
        properties: {
          ruleType: 'Basic'
          httpListener: {
            id: resourceId('Microsoft.Network/applicationGateways/httpListeners', 'appGateway-${environment}', 'httpListener')
          }
          backendAddressPool: {
            id: resourceId('Microsoft.Network/applicationGateways/backendAddressPools', 'appGateway-${environment}', 'backendPool')
          }
          backendHttpSettings: {
            id: resourceId('Microsoft.Network/applicationGateways/backendHttpSettingsCollection', 'appGateway-${environment}', 'defaultHttpSettings')
          }
        }
      }
    ]
    backendHttpSettingsCollection: [
      {
        name: 'defaultHttpSettings'
        properties: {
          port: 80
          protocol: 'Http'
          cookieBasedAffinity: 'Disabled'
          requestTimeout: 20
        }
      }
    ]
    webApplicationFirewallConfiguration: {
      enabled: true
      firewallMode: 'Prevention' // Nebo 'Detection' pro monitorování
      ruleSetType: 'OWASP'
      ruleSetVersion: '3.2'
    }
  }
}

output appGatewayId string = appGateway.id
output publicIpAddress string = publicIp.properties.ipAddress
