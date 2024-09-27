# Install K3K Helm Chart on new RKE2 Cluster
module "configure_cluster_app_cluster" {
  source = "${path.module}/modules/helm_install_k3k"
  kubeconfig_path = var.kubeconfig_path
}

# Create k3k cluster
module "rancher_cluster" {
  source          = "${path.module}/modules/cluster"
  k3k_cli_url     = "https://github.com/rancher/k3k/releases/download/v0.2.1/k3kcli"
  cluster_name    = "rancher-cluster"
  kubeconfig_path = var.kubeconfig_path
}

# Get k3k kubeconfig
output "rancher_kubeconfig" {
	value = module.rancher_cluster.cluster_kube_config_path
}

# Create k3k cluster for SUSE Observability 
## https://docs.stackstate.com/get-started/k8s-getting-started
module "suse_observability_cluster" {
  source          = "${path.module}/modules/cluster"
  k3k_cli_url     = "https://github.com/rancher/k3k/releases/download/v0.2.1/k3kcli"
  cluster_name    = "suse-observability-cluster"
  kubeconfig_path = "${path.module}/kubeconfig.yaml"
}

# Get k3k kubeconfig
output "suse_observability_kubeconfig" {
        value = module.suse_observability_cluster.cluster_kube_config_path
}


