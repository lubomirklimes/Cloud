param location string
param environment string
param objectId string // Objekt ID Managed Identity nebo uživatele, který potřebuje přístup

resource keyVault 'Microsoft.KeyVault/vaults@2023-07-01' = {
  name: 'kv-lcs-${environment}'
  location: location
  properties: {
    sku: {
      family: 'A'
      name: 'standard'
    }
    tenantId: subscription().tenantId
    enableRbacAuthorization: false // Použití Access Policies
    accessPolicies: [ // Definice přístupových zásad
      {
        tenantId: subscription().tenantId
        objectId: objectId // Managed Identity Application Gateway
        permissions: {
          secrets: [
            'get'
            'list'
          ]
        }
      }
    ]
    networkAcls: {
      bypass: 'AzureServices' // Povolení Trusted Microsoft Services
      defaultAction: 'Deny'
    }
    enableSoftDelete: true
    enabledForDeployment: true
    enabledForTemplateDeployment: true
    enabledForDiskEncryption: false
  }
}

output keyVaultId string = keyVault.id
output keyVaultUri string = keyVault.properties.vaultUri
