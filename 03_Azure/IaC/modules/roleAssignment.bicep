param principalId string

resource roleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(subscription().tenantId, 'KeyVault Secrets User', principalId) // Použijeme tenant jako unikátní identifikátor
  scope: tenant() // Nastavení scope na tenant
  properties: {
    roleDefinitionId: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '4633458b-17de-408a-b874-0445c86b69e6') // Role Key Vault Secrets User
    principalId: principalId
  }
}
