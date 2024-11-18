Networking v Azure: Základy a doporučení
========================================

Správně navržená síťová architektura je klíčem k úspěšné implementaci cloudové infrastruktury. Azure nabízí širokou škálu síťových služeb pro propojení zdrojů, optimalizaci výkonu aplikací a zabezpečení komunikace. Tento článek popisuje klíčové síťové služby v Azure, jejich funkce, použití a příklady konkrétních scénářů, kdy je vhodné je nasadit.

* * * * *

1\. **Azure Application Gateway**
---------------------------------

### Popis

Azure Application Gateway je služba pro doručování aplikací, která poskytuje vyvažování zátěže na aplikační vrstvě (OSI vrstva 7). Mezi klíčové funkce patří:

-   Vyvažování HTTP zátěže.
-   Směrování obsahu na základě URL.
-   Hostování více webů na jedné bráně.
-   Ochrana pomocí **Web Application Firewallu (WAF)** proti útokům, jako je **cross-site scripting**.

### Příklady použití

-   **Vhodné pro:** Webové aplikace vyžadující směrování provozu na základě URL nebo ochranu pomocí WAF.
-   **Příklad:** E-commerce platforma s různými sekcemi (produkty, zákaznická podpora) na různých doménách.

### Ceny

-   $0.246 za hodinu provozu brány.

* * * * *

2\. **Azure Content Delivery Network (CDN)**
--------------------------------------------

### Popis

Azure CDN optimalizuje doručování obsahu s vysokou šířkou pásma prostřednictvím globálních cache. Primárně je zaměřen na **statický obsah** (dokumenty, obrázky), ale podporuje i **dynamický obsah**.

### Příklady použití

-   **Vhodné pro:** Webové stránky nebo aplikace s vysokými nároky na rychlé doručování obsahu.
-   **Příklad:** Globální streamingová platforma nebo hostování velkých souborů.

### Ceny

-   $0.081 za GB až do prvních 10 TB za měsíc.

* * * * *

3\. **Azure Domain Name System (DNS)**
--------------------------------------

### Popis

Azure DNS umožňuje hostování a správu DNS záznamů. Podporuje:

-   Veřejné domény.
-   Soukromé DNS zóny pro virtuální sítě (VNet).
-   Integraci s Azure CLI a PowerShellem.

### Příklady použití

-   **Vhodné pro:** Organizace, které potřebují spravovat veřejné i soukromé domény.
-   **Příklad:** Nastavení interní domény pro aplikace běžící v rámci VNets.

### Ceny

-   $0.5 za zónu měsíčně (prvních 25 zón).

* * * * *

4\. **Azure ExpressRoute**
--------------------------

### Popis

ExpressRoute nabízí privátní připojení mezi on-premises infrastrukturou a Azure. Výhody zahrnují:

-   Nízkou latenci.
-   Vysokou spolehlivost.
-   Možnost připojení přes poskytovatele, jako je **Comcast** nebo **AT&T**.

### Příklady použití

-   **Vhodné pro:** Kritické aplikace vyžadující stabilní a rychlé připojení.
-   **Příklad:** Bankovní systémy připojené k datovým centrům Azure.

### Ceny

-   $55 měsíčně za 50 Mbps.

* * * * *

5\. **Azure Front Door**
------------------------

### Popis

Front Door kombinuje funkce CDN a bezpečnostních služeb, včetně:

-   WAF.
-   Ochrany proti DDoS.
-   Globálního vyvažování zátěže.

### Příklady použití

-   **Vhodné pro:** Dynamické webové aplikace s globálními uživateli.
-   **Příklad:** SaaS aplikace s uživateli po celém světě.

### Ceny

-   $35 měsíčně za standardní plán.

* * * * *

6\. **Azure Load Balancer**
---------------------------

### Popis

Azure Load Balancer zajišťuje vyvažování zátěže na transportní vrstvě (OSI vrstva 4). Podporuje:

-   Veřejné i interní vyvažování zátěže.
-   Automatické přizpůsobení při škálování instancí.

### Příklady použití

-   **Vhodné pro:** Aplikace vyžadující vysokou dostupnost na úrovni VM.
-   **Příklad:** Interní aplikace pro firemní zaměstnance.

### Ceny

-   $0.025 za hodinu pro prvních 5 pravidel.

* * * * *

7\. **Azure Network Watcher**
-----------------------------

### Popis

Network Watcher poskytuje monitorovací nástroje pro sledování síťových prostředků, analýzu logů a diagnostiku problémů.

### Příklady použití

-   **Vhodné pro:** Organizace potřebující přehled o síťovém provozu.
-   **Příklad:** Diagnostika problémů v komunikaci mezi VNets.

* * * * *

8\. **Azure Private Link**
--------------------------

### Popis

Private Link umožňuje bezpečný přístup k Azure PaaS službám prostřednictvím privátního endpointu v rámci VNet.

### Příklady použití

-   **Vhodné pro:** Zabezpečení citlivých dat před přístupem z veřejného internetu.
-   **Příklad:** Přístup k Azure SQL Database přes privátní endpoint.

* * * * *

9\. **Azure Traffic Manager**
-----------------------------

### Popis

Traffic Manager distribuuje uživatelský provoz pomocí DNS směrování. Podporuje různé metody směrování, jako je geografické nebo výkonové.

### Příklady použití

-   **Vhodné pro:** Globální aplikace s požadavkem na minimální latenci.
-   **Příklad:** Online platforma s uživateli v různých regionech.

* * * * *

10\. **Azure Virtual Network (VNet)**
-------------------------------------

### Popis

VNet je izolovaná síť v Azure, která umožňuje:

-   Připojení on-premises infrastruktur přes VPN.
-   Komunikaci mezi zdroji v různých VNets.

### Příklady použití

-   **Vhodné pro:** Izolaci a bezpečnou komunikaci zdrojů.
-   **Příklad:** Nastavení infrastruktury pro vícestupňovou aplikaci.

* * * * *

11\. **Azure Virtual WAN**
--------------------------

### Popis

Virtual WAN kombinuje síťové a bezpečnostní funkce, jako je VPN, ExpressRoute, Azure Firewall a šifrování.

### Příklady použití

-   **Vhodné pro:** Organizace s potřebou škálovatelného síťového řešení.
-   **Příklad:** Centralizovaná síťová infrastruktura pro globální korporaci.

* * * * *

12\. **Azure VPN Gateway**
--------------------------

### Popis

VPN Gateway poskytuje šifrované připojení mezi sítěmi. Nabízí několik typů připojení, včetně **site-to-site** a **VNet-to-VNet**.

### Příklady použití

-   **Vhodné pro:** Bezpečné propojení vzdálených lokalit s Azure.
-   **Příklad:** Připojení firemní pobočky k centrální síti Azure.

* * * * *

### Závěr

Každá služba má specifické funkce a použití, které je třeba pečlivě zvážit podle požadavků aplikace. Plánování síťové architektury je klíčem k úspěšnému nasazení cloudové infrastruktury a optimalizaci výkonu a bezpečnosti.