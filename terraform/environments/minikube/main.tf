module "milvus" {
  source = "../../modules/milvus"

  release_name    = var.milvus_config.release_name
  namespace       = "deeprecall"
  chart_version   = var.milvus_config.chart_version
  cluster_enabled = var.milvus_config.cluster_enabled
  persistence     = var.milvus_config.persistence
  resources       = var.milvus_config.resources
  metrics_enabled = var.milvus_config.metrics_enabled

  providers = {
    kubernetes = kubernetes
    helm       = helm
  }
}

module "tika" {
  source = "../../modules/tika"

  release_name   = var.tika_config.release_name
  namespace      = "deeprecall"
  chart_version  = var.tika_config.chart_version
  image_tag      = var.tika_config.image_tag
  service_type   = var.tika_config.service_type
  service_port   = var.tika_config.service_port
  resources      = var.tika_config.resources
  tika_config    = var.tika_config.custom_config

  providers = {
    helm = helm
  }
}

# module "rabbitmq" {
#   source = "../../modules/rabbitmq"

#   image_version  = var.rabbitmq_config.image_version
#   container_name = var.rabbitmq_config.container_name
#   vhost          = var.rabbitmq_config.vhost
# }

module "wireguard" {
  source = "../../modules/wireguard"
  providers = {
    kubernetes = kubernetes
  }
}

module "rabbitmq_operator" {
  source = "../../modules/rabbitmq-operator"

  providers = {
    kubectl = kubectl
  }
}