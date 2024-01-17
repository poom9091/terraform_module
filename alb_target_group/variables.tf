variable "environment" {
  type    = string
  default = "dev"
}

variable "project_name" {
  type    = string
  default = null
}

variable "service" {
  type    = string
  default = null
}

variable "port" {
  type    = number
  default = 80
}

variable "vpc_id" {
  type    = string
  default = null
}

variable "alb_arn" {
  type    = string
  default = null
}

variable "protocol" {
  type    = string
  default = "HTTP"
}

variable "health_check_path" {
  type    = string
  default = "/"
}
