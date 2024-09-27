resource "random_string" "k3k_token" {
  length  = 16
  special = false
}

resource "null_resource" "k3k_cluster" {
  depends_on = [local_sensitive_file.kubectl]
  provisioner "local-exec" {
    command = "${path.module}/k3kcli cluster create --name ${var.cluster_name} --token ${random_string.k3k_token.result}"
    environment = {
      KUBECONFIG = var.kubeconfig_path
    }
  }
}

resource "null_resource" "delete_k3k_cluster" {

  triggers = {
	cluster_name = var.cluster_name
	kubeconfig_path = var.kubeconfig_path
  }

  provisioner "local-exec" {
    when    = destroy
    command = "${path.module}/k3kcli cluster delete --name ${self.triggers.cluster_name}"
    environment = {
      KUBECONFIG = self.triggers.kubeconfig_path
    }
  }
}

data "http" "k3k_cli" {
  url = var.k3k_cli_url

  request_headers = {
    Accept = "application/octet-stream"
  }
}

resource "local_sensitive_file" "kubectl" {
  filename        = "${path.module}/k3kcli"
  content_base64  = data.http.k3k_cli.response_body_base64
  file_permission = "0755"
}

output "cluster_name" {
  value = var.cluster_name
}

output "cluster_kube_config_path" {
  value = "${path.module}/${var.cluster_name}-kubeconfig.yaml"
}
