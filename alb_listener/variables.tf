variable "alb_arn" {
}
variable "target_group_arn" {}
variable "service_domain_name" {
  default = "null"
}

variable "acm_arn" {
  default = "null"
}
variable "listener_arn" {
  type    = string
  default = null
}
variable "port" {
  type    = number
  default = 443
}
