variable "environment" {
  default = null
}

variable "region" {
  type = string
}

variable "project_name" {
  type    = string
  default = null
}

variable "cluster_id" {
  type    = string
  default = null
}

variable "cluster_name" {
  type    = string
  default = null
}

variable "cpu" {
  type    = number
  default = 256
}

variable "memory" {
  type    = number
  default = 512
}

variable "service" {
  type    = string
  default = null
}

variable "wait_for_steady_state" {
  type    = bool
  default = false
}

variable "container_name" {
  type    = string
  default = null
}

variable "container_image" {
  type    = string
  default = null
}

variable "container_port" {
  type    = number
  default = null
}

variable "ecs_service_security_groups" {
  type    = string
  default = null
}

variable "aws_alb_target_group_arn" {
  type    = string
  default = null
}

variable "health_check_path" {
  type    = string
  default = null
}

variable "security_group_api_gateway" {
  type = map(object({
    protocal   = string
    from_port  = number
    to_port    = number
    cidr_block = list(string)
  }))
  default = null
}

variable "security_group_ecs_task" {
  type = map(object({
    protocal   = string
    from_port  = number
    to_port    = number
    cidr_block = list(string)
  }))
  default = null
}

variable "vpc_id" {
  type    = string
  default = null
}

variable "alb_security_groups" {
  type    = string
  default = null
}

variable "subnets" {
  type    = list(string)
  default = ["", ""]
}

variable "subnets_public" {
  type    = list(string)
  default = [""]
}

variable "env" {
  type    = list(any)
  default = null
}

variable "env_secret" {
  type    = list(any)
  default = null
}

variable "logs_retention_in_days" {
  type    = string
  default = null
}

variable "prefix_path" {
  type    = list(string)
  default = null
}

variable "api_gateway_id" {
  type    = string
  default = null
}

variable "cloudmap_id" {
  type    = string
  default = null
}

variable "cloudmap_arn" {
  type    = string
  default = null
}

variable "vpc_link" {
  type    = string
  default = null
}

variable "sidercar_container" {
  type    = list(any)
  default = []
}

variable "dependsOn_sidercar_container" {
  type    = list(any)
  default = null
}

variable "use_arm64" {
  type    = bool
  default = false
}

variable "expost" {
  type    = string
  default = null
}

variable "desired_count" {
  type    = number
  default = 1
}

variable "deployment_minimum_healthy_percent" {
  type    = number
  default = 100
}

variable "deployment_maximum_percent" {
  type    = number
  default = 200
}

variable "ssl_arn" {
  type    = string
  default = null
}

variable "alb_arn" {
  type    = string
  default = null
}

variable "isBlueGreen" {
  type    = bool
  default = false
}

variable "service_domain_name" {
  type    = string
  default = null
}

variable "acm_arn" {
  type    = string
  default = null
}

variable "listener_arn_main" {
  type    = string
  default = null
}

variable "listener_arn_test" {
  type    = string
  default = null
}

variable "rule_priority" {
  type    = string
  default = null
}

variable "ecr_url" {
  type    = string
  default = null
}

variable "enable_service" {
  type    = bool
  default = false
}

variable "command" {
  type    = list(string)
  default = null
}

variable "container_tag" {
  default = null
}

variable "app_mesh_id" {}
