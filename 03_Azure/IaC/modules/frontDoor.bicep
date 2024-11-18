param environment string
param location string
param frontendHost string // Tento parametr zůstává pro účely směrování (CNAME)
param backendAppServiceUrl string
param appGatewayPublicIp string

resource frontDoorProfile 'Microsoft.Cdn/profiles@2021-06-01' = {
  name: 'frontDoorProfile-${environment}'
  location: location
  sku: {
    name: 'Standard_AzureFrontDoor'
  }
}

resource frontDoorEndpoint 'Microsoft.Cdn/profiles/afdEndpoints@2021-06-01' = {
  name: 'frontDoorEndpoint-${environment}'
  parent: frontDoorProfile
  location: location
  properties: {
    enabledState: 'Enabled'
  }
}

resource frontDoorBackendPool 'Microsoft.Cdn/profiles/backendPools@2021-06-01' = {
  name: 'backendPool-${environment}'
  parent: frontDoorProfile
  properties: {
    backends: [
      {
        address: appGatewayPublicIp
        enabledState: 'Enabled'
        priority: 1
        weight: 1
        backendHostHeader: frontendHost
        httpPort: 80
        httpsPort: 443
      }
      {
        address: backendAppServiceUrl
        enabledState: 'Enabled'
        priority: 2
        weight: 1
        backendHostHeader: frontendHost
        httpPort: 80
        httpsPort: 443
      }
    ]
  }
}

resource frontDoorRoute 'Microsoft.Cdn/profiles/routes@2021-06-01' = {
  name: 'route-${environment}'
  parent: frontDoorProfile
  properties: {
    acceptedProtocols: [
      'Http'
      'Https'
    ]
    patternsToMatch: [
      '/*'
    ]
    forwardingProtocol: 'HttpsOnly'
    linkToBackendPool: {
      id: frontDoorBackendPool.id
    }
    httpsRedirect: 'Enabled'
  }
}
