terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "2.15.0"
    }
  }
}

provider "helm" {
  kubernetes {
    config_path = var.kubeconfig_path
  }
}

resource "helm_release" "k3k" {
  name       = "redis"
  repository = "https://rancher.github.io/k3k"
  chart      = "k3k"
  devel      = true
}
