variable "release_name" {
  description = "Name of the Helm release"
  type        = string
  default     = "tika"
}

variable "namespace" {
  description = "Target namespace for installation"
  type        = string
  default     = "deeprecall"
}

variable "chart_version" {
  description = "Tika Helm chart version"
  type        = string
  default     = "2.9.0-full" # Match Tika server version
}

variable "image_tag" {
  description = "Docker image tag for Tika"
  type        = string
  default     = "2.9.0.0-full" # Official image tag format
}

variable "service_type" {
  description = "Kubernetes service type"
  type        = string
  default     = "ClusterIP"
}

variable "service_port" {
  description = "Tika service port"
  type        = number
  default     = 9998
}

variable "resources" {
  description = "Resource limits for Tika"
  type = object({
    cpu_limit    = string
    memory_limit = string
  })
  default = {
    cpu_limit    = "2000m"
    memory_limit = "4Gi"
  }
}

variable "tika_config" {
  description = "Custom Tika configuration XML"
  type        = string
  default     = ""
}