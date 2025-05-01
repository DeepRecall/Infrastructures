terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "~> 2.36"
    }
  }
}

resource "kubernetes_persistent_volume_claim" "wireguard" {
  metadata {
    name      = "pv-claim-wireguard"
    namespace = "deeprecall"
  }
  spec {
    storage_class_name = "standard"
    access_modes       = ["ReadWriteOnce"]
    resources {
      requests = {
        storage = "10M"
      }
    }
  }
}

resource "kubernetes_config_map" "wireguard" {
  metadata {
    name      = "wireguard-configmap"
    namespace = "deeprecall"
  }
  data = {
    PUID          = "1000"
    PGID          = "1000"
    TZ            = "America/New_York"
    SERVERPORT    = "51820"
    PEERS         = "1"
    PEERDNS       = "auto"
    INTERNAL_SUBNET = "10.13.13.0"
    ALLOWEDIPS    = "0.0.0.0/0, ::/0"
    PERSISTENTKEEPALIVE_PEERS = "all"
  }
}

resource "kubernetes_pod" "wireguard" {
  metadata {
    name      = "wireguard"
    namespace = "deeprecall"
    labels = {
      app = "wireguard"
    }
  }
  spec {
    container {
      name  = "wireguard"
      image = "lscr.io/linuxserver/wireguard"
      env_from {
        config_map_ref {
          name = kubernetes_config_map.wireguard.metadata[0].name
        }
      }
      security_context {
        capabilities {
          add = ["NET_ADMIN", "SYS_MODULE"]
        }
        privileged = true
      }
      volume_mount {
        name      = "wg-config"
        mount_path = "/config"
      }
      volume_mount {
        name      = "host-volumes"
        mount_path = "/lib/modules"
      }
      port {
        container_port = 51820
        protocol       = "UDP"
      }
      resources {
        requests = {
          memory = "64Mi"
          cpu    = "100m"
        }
        limits = {
          memory = "128Mi"
          cpu    = "200m"
        }
      }
    }
    volume {
      name = "wg-config"
      persistent_volume_claim {
        claim_name = kubernetes_persistent_volume_claim.wireguard.metadata[0].name
      }
    }
    volume {
      name = "host-volumes"
      host_path {
        path = "/lib/modules"
        type = "Directory"
      }
    }
  }
}

resource "kubernetes_service" "wireguard" {
  metadata {
    labels = {
      k8s-app = "wireguard"
    }
    name      = "wireguard-service"
    namespace = "deeprecall"
  }
  spec {
    type = "NodePort"
    port {
      port        = 51820
      node_port   = 31820
      protocol    = "UDP"
      target_port = 51820
    }
    selector = {
      app = "wireguard"
    }
  }
}
