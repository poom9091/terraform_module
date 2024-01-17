variable "project_name" {
  type    = string
  default = "rmw"
}

variable "slack_workspace_id" {
  type = string
}

variable "slack_channel_id" {
  type = string
}

variable "sns" {
  type = list(string)
}
