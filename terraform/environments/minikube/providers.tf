terraform {
  required_version = ">= 1.6"

  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.36"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.17"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "~> 1.19"
    }
  }
}

provider "kubernetes" {
  config_path    = pathexpand(var.kube_config_path)
  config_context = "minikube"
}

provider "helm" {
  kubernetes {
    config_path    = pathexpand(var.kube_config_path)
    config_context = "minikube"
  }
}

provider "kubectl" {
  config_path    = pathexpand(var.kube_config_path)
  config_context = "minikube"
}

data "local_file" "kubeconfig" {
  filename = pathexpand(var.kube_config_path)
}

output "kubeconfig_content" {
  value = data.local_file.kubeconfig.content
}