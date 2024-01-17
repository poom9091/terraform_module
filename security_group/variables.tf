variable "name" {
  type    = string
  default = "null"
}

variable "vpc_id" {
  type    = string
  default = "null"
}

variable "security_groups_ingress_role" {
  type = map(object({
    protocal   = string
    from_port  = number
    to_port    = number
    cidr_block = list(string)
  }))
  default = {
    HTTP = {
      protocal   = "tcp"
      from_port  = 80
      to_port    = 80
      cidr_block = ["0.0.0.0/0"]
    }
    HTTPS = {
      protocal   = "tcp"
      from_port  = 443
      to_port    = 443
      cidr_block = ["0.0.0.0/0"]
    }
  }
}
