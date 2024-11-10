param location string
param aksClusterName string
param nodeCount int
param nodeVMSize string
param kubernetesVersion string
param adminUsername string
@secure()
param sshPublicKey string

resource aks 'Microsoft.ContainerService/managedClusters@2022-09-01' = {
  name: aksClusterName
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    kubernetesVersion: kubernetesVersion
    dnsPrefix: 'aksdns-${uniqueString(resourceGroup().id)}'
    agentPoolProfiles: [
      {
        name: 'nodepool1'
        count: nodeCount
        vmSize: nodeVMSize
        osType: 'Linux'
        mode: 'System'
      }
    ]
    linuxProfile: {
      adminUsername: adminUsername
      ssh: {
        publicKeys: [
          {
            keyData: sshPublicKey
          }
        ]
      }
    }
    networkProfile: {
      networkPlugin: 'azure'
      loadBalancerSku: 'standard'
    }
    // Optional: Uncomment if `servicePrincipalProfile` is needed in your setup
    // servicePrincipalProfile: {
    //   clientId: '<client-id>'
    //   secret: '<client-secret>'
    // }
  }
}

output aksClusterName string = aks.name
