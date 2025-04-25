variable "image_version" {
  description = "The version of the RabbitMQ Docker image to use"
  type        = string
  default     = "4"
}

variable "container_name" {
  description = "The name for the Kubernetes deployment and container"
  type        = string
  default     = "rabbitmq"
}

variable "vhost" {
  description = "The default virtual host for RabbitMQ"
  type        = string
  default     = "my_vhost"
}