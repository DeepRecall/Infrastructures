variable "kube_config_path" {
  description = "Path to kubeconfig file"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "milvus_config" {
  description = "Milvus module configuration"
  type = object({
    release_name    = string
    chart_version   = string
    cluster_enabled = bool
    persistence = object({
      enabled       = bool
      storage_size  = string
      storage_class = optional(string)
    })
    resources = object({
      cpu_limit    = string
      memory_limit = string
    })
    metrics_enabled = bool
  })
}

variable "tika_config" {
  description = "Tika module configuration"
  type = object({
    release_name    = string
    chart_version = string
    image_tag     = string
    service_type  = string
    service_port  = number
    resources = object({
      cpu_limit    = string
      memory_limit = string
    })
    custom_config = string
  })
}

variable "rabbitmq_config" {
  description = "RabbitMQ module configuration"
  type = object({
    image_version = string
    container_name = string
    vhost = string
  })
  default = {
    image_version = "4"
    container_name = "rabbitmq"
    vhost = "my_vhost"
  }
}