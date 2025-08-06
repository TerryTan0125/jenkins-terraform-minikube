variable "namespace" {
  description = "Kubernetes namespace to deploy"
  type        = string
  default     = "tomcat-ns"
}

variable "app_name" {
  description = "Application label name"
  type        = string
  default     = "tomcat"
}

variable "app_image" {
  description = "Docker image for the app"
  type        = string
  default     = "tomcat:9.0"
}

variable "replica_count" {
  description = "Number of pod replicas"
  type        = number
  default     = 1
}

variable "service_port" {
  description = "Port exposed by the service"
  type        = number
  default     = 8080
}
