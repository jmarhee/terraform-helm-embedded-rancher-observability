variable "kubeconfig_path" {}
variable "rancher_helm_values_base64" {}
variable "rancher_helm_repo" {
	default = "https://releases.rancher.com/server-charts/stable"
	description = "Helm Repo for Rancher"
}
variable "suse_observability_repo" {}
variable "suse_observability_helm_values_base64" {}
