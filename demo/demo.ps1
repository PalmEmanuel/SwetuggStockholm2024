# Pre-session

## Create Codespace

# Demo

## Start Codespace
## Connect to Codespace from VS Code

```
rad init --full
# - Yes
rad deploy app.bicep -a demo
rad resource expose containers demo -a demo --port 1337 --remote-port 3000
```