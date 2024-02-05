# Demo Notes

## Pre-session

### Create Codespace

### Initialize cluster

```plaintext
k3d cluster delete
k3d cluster create -p "8081:80@loadbalancer" --k3s-arg "--disable=traefik@server:0"
rad install kubernetes --set rp.publicEndpointOverride=localhost:8081
rad init
- Yes
```

### Deploy eShop example

```plaintext
rad deploy samples/eshop/eshop.bicep
```

### Deploy Dashboard

```plaintext
kubectl apply -f https://raw.githubusercontent.com/radius-project/dashboard/main/deploy/dashboard.yaml
```

### Start Codespace

### Connect to Codespace from VS Code

## Demo

### Go through app.bicep

```plaintext
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

```plaintext
rad connections show 
```

### Expose eShop container

```plaintext
rad resource expose -a eshop containers web-spa --port 5000 --remote-port 80
```

### Show Dashboard

```plaintext
kubectl port-forward --namespace=radius-system svc/dashboard 3000:80
```
