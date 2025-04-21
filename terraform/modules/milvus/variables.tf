variable "release_name" {
  description = "Name of the Helm release"
  type        = string
}

variable "namespace" {
  description = "Target namespace for installation"
  type        = string
}

variable "chart_version" {
  description = "Milvus Helm chart version"
  type        = string
}

variable "cluster_enabled" {
  description = "Enable cluster mode"
  type        = bool
  default     = false
}

variable "persistence" {
  description = "Persistent volume configuration"
  type = object({
    enabled      = bool
    storage_size = string
    storage_class = optional(string)
  })
  default = {
    enabled      = true
    storage_size = "20Gi"
  }
}

variable "resources" {
  description = "Resource limits for standalone mode"
  type = object({
    cpu_limit    = string
    memory_limit = string
  })
  default = {
    cpu_limit    = "2000m"
    memory_limit = "4Gi"
  }
}

variable "metrics_enabled" {
  description = "Enable Prometheus metrics"
  type        = bool
  default     = false
}