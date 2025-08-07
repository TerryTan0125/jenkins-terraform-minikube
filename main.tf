terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
  }
}

provider "kubernetes" {
  config_path = "/home/jenkins/.kube/config"
}

resource "kubernetes_namespace" "app_ns" {
  metadata {
    name = var.namespace
  }
}

resource "kubernetes_deployment" "app" {
  metadata {
    name      = "${var.app_name}-deployment"
    namespace = kubernetes_namespace.app_ns.metadata[0].name
    labels = {
      app = var.app_name
    }
  }

  spec {
    replicas = var.replica_count
    selector {
      match_labels = {
        app = var.app_name
      }
    }
    template {
      metadata {
        labels = {
          app = var.app_name
        }
      }
      spec {
        container {
          image = var.app_image
          name  = var.app_name
          port {
            container_port = var.service_port
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "app_svc" {
  metadata {
    name      = "${var.app_name}-service"
    namespace = kubernetes_namespace.app_ns.metadata[0].name
  }

  spec {
    selector = {
      app = kubernetes_deployment.app.metadata[0].labels.app
    }

    port {
      port        = var.service_port
      target_port = var.service_port
    }

    type = "NodePort"
  }
}
