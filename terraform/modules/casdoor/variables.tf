variable "release_name" {
  description = "Name of the Helm release"
  type        = string
}

variable "namespace" {
  description = "Target namespace for installation"
  type        = string
}

variable "chart_version" {
  description = "Casdoor Helm chart version"
  type        = string
}

variable "service_type" {
  description = "Kubernetes service type (ClusterIP, NodePort, LoadBalancer)"
  type        = string
  default     = "ClusterIP"
}

variable "replica_count" {
  description = "Number of replicas of the Casdoor application to run"
  type        = number
  default     = 1
}

variable "database" {
  description = "Database configuration for Casdoor"
  type = object({
    driver      = string
    user        = string
    password    = string
    host        = string
    port        = string
    databaseName = string
    sslMode     = string
  })
  default = {
    driver      = "sqlite3"
    user        = ""
    password    = ""
    host        = ""
    port        = ""
    databaseName = "casdoor"
    sslMode     = "disable"
  }
}
