# PostgreSQL

variable "namespace" {
  description = "Target namespace for installation"
  type        = string
}

variable "chart_version" {
  description = "Version of the Helm chart to use"
  type        = string
  default     = "16.6.6"
}

variable "postgresql" {
  description = "Configuration for PostgreSQL"
  type = object({
    global = object({
      postgresql = object({
        auth = object({
          database = string
          username = string
          password = string
        })
      })
    })
    service = object({
      type = string
    })
    architecture = string
    readReplicas = object({
      replicaCount = string
    })
  })
  default = {
    global = {
      postgresql = {
        auth = {
          database = "casdoor"
          username = "admin"
          password = "placeholder"
        }
      }
    }
    service = {
      type = "ClusterIP"
    }
    architecture = "replication"
    readReplicas = {
      replicaCount = "1"
    }
  }
}