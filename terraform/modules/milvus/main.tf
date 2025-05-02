terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "~> 2.36"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.17"
    }
  }
}

resource "helm_release" "milvus" {
  name       = var.release_name
  repository = "https://zilliztech.github.io/milvus-helm"
  chart      = "milvus"
  version    = var.chart_version
  namespace  = var.namespace

  set {
    name  = "service.type"
    value = var.service_type
  }

  set {
    name  = "cluster.enabled"
    value = var.cluster_enabled
  }

  set {
    name  = "standalone.persistence.enabled"
    value = var.persistence.enabled
  }

  set {
    name  = "standalone.persistence.size"
    value = var.persistence.storage_size
  }

  set {
    name  = "standalone.resources.limits.cpu"
    value = var.resources.cpu_limit
  }

  set {
    name  = "standalone.resources.limits.memory"
    value = var.resources.memory_limit
  }

  set {
    name  = "metrics.enabled"
    value = var.metrics_enabled
  }
}