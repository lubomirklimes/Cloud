param location string
param environment string

resource managedIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2023-01-31' = {
  name: 'managedIdentity-${environment}'
  location: location
}

output objectId string = managedIdentity.properties.principalId // Object ID
output identityId string = managedIdentity.id // Resource ID
