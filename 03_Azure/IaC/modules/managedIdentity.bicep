param location string
param environment string

resource managedIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2023-01-31' = {
  name: 'appGatewayIdentity-${environment}'
  location: location
}

output identityId string = managedIdentity.id
output objectId string = managedIdentity.properties.principalId
