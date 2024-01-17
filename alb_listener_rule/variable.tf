variable "listener_arn" {
  type    = string
  default = null
}
variable "target_group_arn" {}
variable "service_domain_name" {
  type    = string
  default = null
}
variable "rule_priority" {}
