### Navržená architektura

1.  **Frontend a Backend aplikace**:

    -   Backend: REST API server, který poskytuje data a logiku.
    -   Frontend: Blazor aplikace, která komunikuje s backendem přes API.
    -   Obě aplikace budou kontejnerizované a nasazené na **Azure Kubernetes Service (AKS)**.

2.  **Kubernetes Cluster s Load Balancerem**:

    -   Nasazení dvou nodů pro zvýšení dostupnosti. Frontend i backend aplikace budou provozovány v oddělených **pods**.
    -   **Azure Load Balancer** bude nasměrován na Kubernetes pro rozdělení zátěže mezi nody.

3.  **API Management (APIM)**:

    -   V Azure API Management bude API backendu vystaveno klientům a aplikaci Blazor.
    -   APIM poskytne bezpečnostní vrstvy, limity a řízení přístupu.

4.  **CI/CD pipelines v Azure DevOps**:

    -   **Continuous Integration**: Pipeline, která sestaví a otestuje aplikace (backend i frontend).
    -   **Continuous Deployment**: Pipeline, která pushne Docker obrazy do **Azure Container Registry (ACR)** a nasadí je do AKS.

### Základní kroky implementace

#### 1\. Nastavení Azure prostředí

-   **AKS Cluster**: Vytvoř AKS s 2 nody, jak jsme již popisovali. Tento cluster bude hostit aplikace a Load Balancer pro směrování provozu mezi nody.
-   **Azure API Management**: Konfiguruj APIM pro zpřístupnění backendového API.
-   **Azure Container Registry (ACR)**: Použij ACR pro ukládání Docker obrazů.

#### 2\. CI/CD pipeline v Azure DevOps

-   **Build Pipeline**: Sestavení Docker obrazů a push do ACR.
-   **Release Pipeline**: Nasazení Docker obrazů do AKS, včetně aplikace Blazor i backendu.

#### 3\. Skripty a konfigurace

1.  **Kubernetes YAML Manifests**:

    -   Deployment a Service manifesty pro backend a frontend, které budou nasazeny do AKS.

2.  **API Management Policies**:

    -   Definuj pravidla pro throttling, autentizaci, případně caching.

3.  **Azure DevOps YAML Pipelines**:

    -   Skripty pro build a release pipeliny.

### Co si ohlídat

1.  **Autentizace a bezpečnost**: Pokud API poskytuje citlivá data, implementuj autentizaci v APIM a Kubernetes Secret pro konfiguraci citlivých údajů.
2.  **Monitoring a Logging**: Využij **Azure Monitor** a **Azure Log Analytics** pro sledování výkonnosti a chyb aplikace.
3.  **Networking**: Nastavení síťových pravidel, aby Kubernetes nody byly dostupné jen přes Load Balancer a APIM.
4.  **Škálování a dostupnost**: Měj na paměti horizontální škálování a failover, pokud by nody v AKS měly problém.

### Kroky k realizaci

1.  Azure Bicep šablon pro vytvoření AKS, ACR a APIM.
2.  Kubernetes YAML manifestů pro backend a frontend.
3.  CI/CD YAML pipeline v Azure DevOps pro build a deploy.
4.  Ukázkového kódu pro Blazor a backend API.

Template_IaC/
│
├── main.bicep              # Hlavní Bicep šablona, která volá jednotlivé moduly
│
├── modules/
│   ├── aks.bicep           # Modul pro Azure Kubernetes Service (AKS)
│   ├── acr.bicep           # Modul pro Azure Container Registry (ACR)
│   └── apim.bicep          # Modul pro Azure API Management (APIM)
│
├── parameters/
│   ├── dev.parameters.json # Parametry pro prostředí DEV
│   ├── test.parameters.json # Parametry pro prostředí TEST
│   └── prod.parameters.json # Parametry pro prostředí PROD
│
└── README.md               # Dokumentace k repozitáři a pokyny pro nasazení

az deployment group create \
  --resource-group myResourceGroup \
  --template-file main.bicep \
  --parameters @parameters/dev.parameters.json

### Odhad měsíčních nákladů

1.  **Azure Kubernetes Service (AKS)**:

    -   Dva nody s VM velikosti `Standard_B2s` (2 jádra, 4 GB RAM).
    -   Cena za `Standard_B2s` je přibližně 0.05 USD/hodina.
    -   **Náklady na AKS**:
        -   2nody×0.05USD/hod×24hod/den×30dnıˊ≈72USD2 \, \text{nody} \times 0.05 \, \text{USD/hod} \times 24 \, \text{hod/den} \times 30 \, \text{dní} \approx 72 \, \text{USD}2nody×0.05USD/hod×24hod/den×30dnıˊ≈72USD
2.  **Azure Container Registry (ACR)**:

    -   S SKU **Basic** (použití pro malé projekty).
    -   Měsíční náklady jsou přibližně 0.167 USD/měsíc.
    -   **Náklady na ACR**:
        -   0.167USD/meˇsıˊc0.167 \, \text{USD/měsíc}0.167USD/meˇsıˊc
3.  **Azure API Management (APIM)**:

    -   Pokud použijeme SKU **Developer** (pro vývoj a testování).
    -   Náklady jsou přibližně 50 USD/měsíc.
    -   **Náklady na APIM**:
        -   50USD/meˇsıˊc50 \, \text{USD/měsíc}50USD/meˇsıˊc

#### Celkový odhad nákladů

**Celkové měsíční náklady**:

-   AKS: 72 USD
-   ACR: 0.167 USD
-   APIM: 50 USD

**Odhadované měsíční náklady = 72 + 0.167 + 50 ≈ 122.17 USD**