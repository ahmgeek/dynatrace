# Infra repo
Contains the setup of the infra with helmcharts using helmfiles

# usage
- `helmfile --environment production -f helm/helmfiles/namespaces.yaml apply` to create namespaces either locally on to whatever cluster yo uare connected to
- `helmfile --environment production -f helm/helmfiles/thanos.yaml apply` Installs the monitoring cluster (Not yet stable)
- `helm uninistall -n NAMESPACE $name` purge the chart/installation

There's `deploy-ghost-infra.sh` which acts as deployer, it's doesn't exist upstream so far due to security.
