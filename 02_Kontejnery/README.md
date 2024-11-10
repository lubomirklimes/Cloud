### Postup pro nasazení aplikace do Kubernetes s využitím Docker registry

#### 1\. **Vytvoříme jednoduchou Python aplikaci**

Začneme tím, že vytvoříme jednoduchou aplikaci v Pythonu s použitím Flasku. Vytvoříme soubor `app.py` s následujícím obsahem:

```
from flask import Flask

app = Flask(__name__)

@app.route('/')
def hello_world():
    return 'Hello, World!'

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80)
```

Tato aplikace spustí jednoduchý webový server, který na root (/) vrátí text "Hello, World!".

#### 2\. **Vytvoříme Dockerfile pro aplikaci**

Dále vytvoříme `Dockerfile`, který popisuje, jak vytvořit Docker obraz z naší aplikace. Tento soubor by měl vypadat takto:

```
FROM python:3.11-slim
WORKDIR /app
COPY app.py .
RUN pip install flask
CMD ["python", "app.py"]
```

Tento `Dockerfile` použije obraz Pythonu, nainstaluje Flask a zkopíruje `app.py` do pracovního adresáře `/app`. Poté spustí aplikaci pomocí příkazu `python app.py`.

#### 3\. **Vytvoříme Docker obraz**

S těmito dvěma soubory (`app.py` a `Dockerfile`) vytvoříme Docker obraz. Použijeme následující příkaz pro vytvoření obrazu:

`docker build -t hello-world .`

Tento příkaz vytvoří Docker obraz s názvem `hello-world`.

#### 4\. **Označíme obraz pro push do Docker registry**

Pokud chceme pushnout obraz do Docker registry, označíme ho pomocí následujícího příkazu:

`docker tag hello-world docker-login/hello-world:latest`

Tento příkaz označí obraz jako `docker-login/hello-world:latest`, což je název, pod kterým bude obraz nahrán do vašeho Docker registry.

#### 5\. **Přihlásíme se do Docker Hubu (nebo jiného registry)**

Pokud ještě nejsme přihlášeni, použijeme příkaz pro přihlášení do Docker Hubu (nebo jiného registry, který používáme):

`docker login`

Po zadání přihlašovacích údajů se přihlásíme do Docker registry.

#### 6\. **Pushneme obraz do Docker registry**

Po označení obrazu a přihlášení do Docker Hubu použijeme následující příkaz pro pushnutí obrazu do registry:

`docker push docker-login/hello-world:latest`

Tento příkaz nahraje náš obraz do repozitáře `hello-world` na Docker Hubu pod vaším uživatelským jménem `docker-login`.

#### 7\. **Změníme Kubernetes YAML soubor pro použití obrazu z Docker registry**

Vytvoříme Kubernetes Deployment soubor `helloworld.yaml`, který bude používat Docker registry. Použijeme název obrazu ve formátu `<docker-username>/<repository>:<tag>`, tedy v tomto případě `docker-login/hello-world:latest`:

```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: hello-world
spec:
  replicas: 1
  selector:
    matchLabels:
      app: hello-world
  template:
    metadata:
      labels:
        app: hello-world
    spec:
      containers:
      - name: hello-world
        image: docker-login/hello-world:latest
        ports:
        - containerPort: 80
---
apiVersion: v1
kind: Service
metadata:
  name: hello-world
spec:
  type: NodePort
  ports:
  - port: 80
    targetPort: 80
  selector:
    app: hello-world
```

#### 8\. **Nasadíme aplikaci do Kubernetes**

Nyní použijeme příkaz pro aplikaci konfigurace do Kubernetes:

`kubectl apply -f helloworld.yaml`

Tímto způsobem Kubernetes stáhne obraz z Docker Hubu (nebo jiného registry, pokud používáme jiný) a nasadí aplikaci.

#### 9\. **Ověříme nasazení**

Pokud chceme zkontrolovat stav nasazení, použijeme následující příkaz:

`kubectl get pods`

Tento příkaz nám ukáže stav našich podů a zda byla aplikace úspěšně nasazena.

#### 10\. **Testujeme přístup k aplikaci**

Službu zpřístupníme příkazem:
`minikube service hello-world`
a příkazem
`curl http://<ip>:<port>/`
získáme odpověď od aplikace, která běží na Kubernetes.
