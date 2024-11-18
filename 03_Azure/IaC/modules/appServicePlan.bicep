param location string
param environment string

resource appServicePlan 'Microsoft.Web/serverfarms@2022-03-01' = {
  name: 'appServicePlan-${environment}'
  location: location
  sku: {
    name: 'F1'
    tier: 'Free'
    size: 'F1'
  }
  properties: {
    reserved: false // Indikuje, že plán není pro Linux (pro Linux by bylo true)
  }
}

output planId string = appServicePlan.id
