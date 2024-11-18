az provider register --namespace Microsoft.Network

Vytvoření Resource Groups pro všechna prostředí:
az group create --name <ResourceGroupName> --location <Location>

az bicep build --file <path_to_bicep_file>

az deployment group create \
  --resource-group <ResourceGroupName> \
  --template-file main.bicep \
  --parameters @parameters/dev.parameters.json


Vytvoření certifikátu pomocí PowerShellu
Použijte PowerShell pro vytvoření certifikátu ve vašem počítači:

Kroky:
Vytvořte certifikát:

powershell
Zkopírovat kód
$cert = New-SelfSignedCertificate -DnsName "yourdomain.com" -CertStoreLocation "Cert:\CurrentUser\My" -FriendlyName "App Gateway Cert" -KeyExportPolicy Exportable

Exportujte certifikát do PFX:

powershell
Zkopírovat kód
$password = ConvertTo-SecureString -String "YourPassword123" -Force -AsPlainText
Export-PfxCertificate -Cert $cert -FilePath "C:\Temp\appgw-cert.pfx" -Password $password
Nahrajte PFX soubor do Key Vault:

powershell
Zkopírovat kód
az keyvault certificate import --vault-name "kv-your-environment" --name "appgw-cert" --file "C:\Temp\appgw-cert.pfx" --password "YourPassword123"
