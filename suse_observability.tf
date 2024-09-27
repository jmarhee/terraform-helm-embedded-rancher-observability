resource "helm_release" "suse_observability" {
  depends_on = [helm_release.rancher]
  name       = "suse_observability"

  create_namespace = true
  namespace = "suse-observability"

  repository = var.suse_observability_repo
  chart      = "suse-observability"

  values = ["${base64decode(var.suse_observability_helm_values_base64)}"]
}
