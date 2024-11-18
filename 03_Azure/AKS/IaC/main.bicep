param location string
param aksClusterName string
param nodeCount int
param nodeVMSize string
param kubernetesVersion string
param adminUsername string
@secure()
param sshPublicKey string

param acrName string = toLower('${aksClusterName}acr')  // ACR název by měl být malými písmeny
param apimName string
param publisherEmail string
param publisherName string
param skuName string = 'Developer' // Můžeš změnit na Standard nebo Premium
param skuCapacity int = 1 // Obvykle 1 pro Developer SKU

module acr 'modules/acr.bicep' = {
  name: 'acrDeployment'
  params: {
    location: location
    acrName: acrName
    sku: 'Basic' // Můžeš změnit na Standard nebo Premium
  }
}

module aks 'modules/aks.bicep' = {
  name: 'aksDeployment'
  params: {
    location: location
    aksClusterName: aksClusterName
    nodeCount: nodeCount
    nodeVMSize: nodeVMSize
    kubernetesVersion: kubernetesVersion
    adminUsername: adminUsername
    sshPublicKey: sshPublicKey
  }
}

module apim 'modules/apim.bicep' = {
  name: 'apimDeployment'
  params: {
    location: location
    apimName: apimName
    publisherEmail: publisherEmail
    publisherName: publisherName
    skuName: skuName
    skuCapacity: skuCapacity
  }
}

output aksClusterName string = aks.outputs.aksClusterName
output acrLoginServer string = acr.outputs.acrLoginServer
output apimGatewayUrl string = apim.outputs.apimGatewayUrl
