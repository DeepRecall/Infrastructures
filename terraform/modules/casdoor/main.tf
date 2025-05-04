terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.17"
    }
  }
}

resource "helm_release" "casdoor" {
  name       = var.release_name
  repository = "oci://registry-1.docker.io/casbin"
  chart      = "casdoor-helm-charts"
  version    = var.chart_version
  namespace  = var.namespace

  set {
    name  = "service.type"
    value = var.service_type
  }

  set {
    name  = "replicaCount"
    value = var.replica_count
  }

  set {
    name  = "database.driver"
    value = var.database.driver
  }

  set {
    name  = "database.user"
    value = var.database.user
  }

  set {
    name  = "database.password"
    value = var.database.password
  }

  set {
    name  = "database.host"
    value = var.database.host
  }

  set {
    name  = "database.port"
    value = var.database.port
  }

  set {
    name  = "database.databaseName"
    value = var.database.databaseName
  }

  set {
    name  = "database.sslMode"
    value = var.database.sslMode
  }
}