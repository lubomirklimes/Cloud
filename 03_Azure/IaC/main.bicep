param environment string
param location string = resourceGroup().location
param appName string

module logAnalytics 'modules/logAnalytics.bicep' = {
  name: 'logAnalytics-${environment}'
  params: {
    location: location
    environment: environment
  }
}

module vnet 'modules/vnet.bicep' = {
  name: 'vnet-${environment}'
  params: {
    location: location
    environment: environment
  }
}

module nsgAppGw 'modules/nsgAppGw.bicep' = {
  name: 'nsgAppGw-${environment}'
  params: {
    location: location
    environment: environment
  }
}

module nsgBackend 'modules/nsgBackend.bicep' = {
  name: 'nsg-backend-${environment}'
  params: {
    location: location
    environment: environment
    appGatewaySubnetCidr: vnet.outputs.appGatewaySubnetPrefix
  }
}

module appServicePlan 'modules/appServicePlan.bicep' = {
  name: 'appServicePlan-${environment}'
  params: {
    location: location
    environment: environment
  }
}

module functionApp 'modules/functionApp.bicep' = {
  name: 'functionApp-${environment}'
  params: {
    appName: appName
    location: location
    environment: environment
    appServicePlanId: appServicePlan.outputs.planId
  }
}

module privateDnsZone 'modules/privateDnsZone.bicep' = {
  name: 'privateDns-${environment}'
  params: {
    environment: environment
    vnetId: vnet.outputs.vnetId
  }
}

module apim 'modules/apim.bicep' = {
  name: 'apim-${environment}'
  params: {
    location: location
    appName: appName
  }
}

module applicationGateway 'modules/appGateway.bicep' = {
  name: 'applicationGateway-${environment}'
  params: {
    environment: environment
    location: location
    subnetId: vnet.outputs.frontendSubnetId
  }
}

module frontDoor 'modules/frontDoor.bicep' = {
  name: 'frontDoor-${environment}'
  params: {
    environment: environment
    location: location
    frontendHost: 'my-app-${environment}.contoso.com' // Změňte na svou doménu
    backendAppServiceUrl: functionApp.outputs.functionAppId
    appGatewayPublicIp: applicationGateway.outputs.publicIpAddress
  }
}
