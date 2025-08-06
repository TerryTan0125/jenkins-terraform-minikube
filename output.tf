output "namespace" {
  value = kubernetes_namespace.app_ns.metadata[0].name
}

output "deployment_name" {
  value = kubernetes_deployment.app.metadata[0].name
}

output "service_name" {
  value = kubernetes_service.app_svc.metadata[0].name
}

output "service_node_port" {
  value = kubernetes_service.app_svc.spec[0].port[0].node_port
}
