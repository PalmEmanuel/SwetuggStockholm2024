## Pre-session

### Create Codespace

```
k3d cluster delete
k3d cluster create -p "8081:80@loadbalancer" --k3s-arg "--disable=traefik@server:0"
rad install kubernetes --set rp.publicEndpointOverride=localhost:8081
rad init
```

## Demo

### Start Codespace

### Connect to Codespace from VS Code

```
rad init
# - Yes
rad deploy app.bicep --application swetugg-demo
rad resource expose containers demo --application swetugg-demo --port 1337 --remote-port 3000
```

### Show the connections of the app

```
rad connections show 
```

### Expose eshop container

```
rad resource expose -a eshop containers web-spa --port 5000 --remote-port 80
```

### Deploy Dashboard

```
kubectl apply -f https://raw.githubusercontent.com/radius-project/dashboard/main/deploy/dashboard.yaml
kubectl port-forward --namespace=radius-system svc/dashboard 3000:80
```
