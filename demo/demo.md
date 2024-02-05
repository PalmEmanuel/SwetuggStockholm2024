# Demo Notes

## Pre-session

### Create Codespace

### Initialize cluster

```ps1
k3d cluster delete
k3d cluster create -p "8081:80@loadbalancer" --k3s-arg "--disable=traefik@server:0"
rad install kubernetes --set rp.publicEndpointOverride=localhost:8081
rad init
# Yes
```

### Deploy eShop example

```ps1
rad deploy samples/eshop/eshop.bicep
```

### Deploy Dashboard

```ps1
kubectl apply -f https://raw.githubusercontent.com/radius-project/dashboard/main/deploy/dashboard.yaml
```

### Start Codespace

### Connect to Codespace from VS Code

## Demo

### Go through app.bicep

```ps1
# https://github.com/radius-project/samples
rad run app.bicep
```

#### Update app.bicep with cache

```bicep
import radius as radius

@description('The Radius Application ID. Injected automatically by the rad CLI.')
param application string

@description('The Radius Environment. Injected automatically by the rad CLI.')
param environment string

resource demo 'Applications.Core/containers@2023-10-01-preview' = {
  name: 'demo'
  properties: {
    application: application
    container: {
      image: 'ghcr.io/radius-project/samples/demo:latest'
      ports: {
        web: {
          containerPort: 3000
        }
      }
    }
    connections: {
      redis: {
        source: cache.id
      }
    }
  }
}

resource cache 'Applications.Datastores/redisCaches@2023-10-01-preview' = {
  name: 'cache'
  properties: {
    application: application
    environment: environment
  }
}
```

### Show the connections of the app

```ps1
rad connections show 
```

### Expose eShop container

```ps1
rad resource expose -a eshop containers web-spa --port 5000 --remote-port 80
```

### Show Dashboard

```ps1
kubectl port-forward --namespace=radius-system svc/dashboard 3000:80
```
