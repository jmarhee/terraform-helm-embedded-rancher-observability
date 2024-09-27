# Rancher & SUSE Observability on k3k

Deploys [k3k embedded k3s clusters](https://github.com/rancher/k3k) for Rancher Manager and [SUSE Observability](https://docs.stackstate.com/get-started/k8s-quick-start-guide) on a provided Kubernetes cluster. 

## Setup

Requires the following variables be set:

`kubeconfig_path`: the path for the target Kubernetes cluster that will host the embedded K3s clusters.
`rancher_repo`: the Helm chart repo for Rancher (default: charts.rancher.io stable branch)
`rancher_helm_values_base64`: base64-encoded Helm chart values file for your Rancher settings.
`suse_observability_repo`: Helm chart repo for SUSE Observability.
`suse_observability_helm_values_base64`: base64-encoded Helm chart values for your [SUSE Observability settings](https://docs.stackstate.com/get-started/k8s-suse-rancher-prime#installing-a-default-ha-setup-for-up-to-250-nodes). 

## Usage

The embedded clusters will be built in modules under `virtual-clusters.tf` and can be `-target`'d by module name, if they need to be reset.

The kubeconfig for each of the clusters will be placed in the output from these modules, and in the module root.

The `cluster` submodule also downloads, and removes upon cluster deletion, the `k3kcli` binary, with which you can manage the embedded clusters as well. See the k3k documentation for details.



