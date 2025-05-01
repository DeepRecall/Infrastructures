terraform {
  required_providers {
    kubectl = {
      source = "gavinbunney/kubectl"
      version = "~> 1.19"
    }
  }
}

# Install RabbitMQ Cluster Operator using Helm
resource "helm_release" "rabbitmq_operator" {
  name       = "rabbitmq-operator"
  repository = "oci://registry-1.docker.io/bitnamicharts"
  chart      = "rabbitmq-cluster-operator"
  namespace  = "deeprecall"

  set {
    name  = "operator.name"
    value = "rabbitmq-cluster-operator"
  }

  # Add other required parameters as needed
}

# Create RabbitMQ Cluster instance
resource "kubectl_manifest" "rabbitmq_cluster" {
  yaml_body = <<YAML
apiVersion: rabbitmq.com/v1beta1
kind: RabbitmqCluster
metadata:
  name: deeprecall-rabbitmq
  namespace: deeprecall
spec:
  service:
    type: NodePort
  replicas: 3
  resources:
    requests:
      memory: "2Gi"
      cpu: "1000m"
    limits:
      memory: "4Gi"
      cpu: "2000m"
  persistence:
    storageClassName: "standard"
    storage: "20Gi"
YAML

  depends_on = [helm_release.rabbitmq_operator]
}