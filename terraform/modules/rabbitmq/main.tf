terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.23"
    }
  }
}

resource "kubernetes_deployment" "rabbitmq" {
  metadata {
    name = var.container_name
    namespace = "deeprecall"
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "rabbitmq"
      }
    }

    template {
      metadata {
        labels = {
          app = "rabbitmq"
        }
      }

      spec {
        container {
          name  = var.container_name
          image = "rabbitmq:${var.image_version}"
          
          env {
            name  = "RABBITMQ_DEFAULT_VHOST"
            value = var.vhost
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "rabbitmq" {
  metadata {
    name = "${var.container_name}-service"
    namespace = "deeprecall"
  }

  spec {
    selector = {
      app = "rabbitmq"
    }

    port {
      port        = 5672
      target_port = 5672
    }
  }
}