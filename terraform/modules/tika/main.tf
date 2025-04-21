resource "helm_release" "tika" {
  name       = var.release_name
  repository = "https://apache.jfrog.io/artifactory/tika"
  chart      = "tika"
  version    = var.chart_version
  namespace  = var.namespace

  set {
    name  = "image.tag"
    value = var.image_tag
  }

  set {
    name  = "service.type"
    value = var.service_type
  }

  set {
    name  = "service.port"
    value = var.service_port
  }

  set {
    name  = "resources.limits.cpu"
    value = var.resources.cpu_limit
  }

  set {
    name  = "resources.limits.memory"
    value = var.resources.memory_limit
  }

  dynamic "set" {
    for_each = var.tika_config != "" ? [1] : []
    content {
      name  = "tikaConfig"
      value = var.tika_config
    }
  }
}