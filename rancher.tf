resource "helm_release" "rancher" {
  depends_on = [module.rancher_cluster]
  name       = "rancher"

  create_namespace = true
  namespace = "cattle-system"

  repository = var.rancher_helm_repo
  chart      = "rancher"

  values = ["${base64decode(var.rancher_helm_values_base64)}"]
}
