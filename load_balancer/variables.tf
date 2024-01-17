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

variable "subnets_public" {
  type    = list(string)
  default = null
}

variable "vpc_id" {
  type    = string
  default = null
}
