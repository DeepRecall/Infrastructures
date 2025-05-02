# main.tf
terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.36"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.17"
    }
  }
}

resource "helm_release" "postgresql" {
  name       = "postgresql"
  repository = "oci://registry-1.docker.io/bitnamicharts"
  chart      = "postgresql"
  namespace  = var.namespace
  version    = var.chart_version

  # Global configuration (applies to both primary and replicas)
  set {
    name  = "global.postgresql.auth.database"
    value = var.postgresql.global.postgresql.auth.database
  }

  set {
    name  = "global.postgresql.auth.username"
    value = var.postgresql.global.postgresql.auth.username
  }

  set {
    name  = "global.postgresql.auth.password"
    value = var.postgresql.global.postgresql.auth.password
  }

  # Service configuration
  set {
    name  = "service.type"
    value = var.postgresql.service.type
  }

  # Enable replication
  set {
    name  = "architecture"
    value = var.postgresql.architecture
  }

  # Configure replica settings
  set {
    name  = "readReplicas.replicaCount"
    value = var.postgresql.readReplicas.replicaCount
  }
}
