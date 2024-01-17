variable "environment" {
  default = null
}

variable "service" {
  default = null
}

variable "region" {
  type = string
}

variable "project_name" {
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

variable "ecr_url" {
  type    = string
  default = null
}

variable "env" {
  type    = list(any)
  default = null
}

variable "env_secret" {
  type    = list(any)
  default = null
}

variable "container_tag" {
  default = null
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

variable "command" {
  type    = list(string)
  default = null
}

variable "logs_retention_in_days" {
  type = number
}
