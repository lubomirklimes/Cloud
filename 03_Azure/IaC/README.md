az provider register --namespace Microsoft.Network

Vytvoření Resource Groups pro všechna prostředí:
az group create --name <ResourceGroupName> --location <Location>

az bicep build --file <path_to_bicep_file>

az deployment group create \
  --resource-group <ResourceGroupName> \
  --template-file main.bicep \
  --parameters @parameters/dev.parameters.json