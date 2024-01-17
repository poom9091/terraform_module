resource "aws_lb" "main" {
  name               = "${var.environment}-${var.project_name}-${var.service}"
  internal           = false
  load_balancer_type = "application"
  subnets            = var.subnets_public
  security_groups    = [tostring(module.service_security_group.securiyt_group_id)]

  enable_deletion_protection = true
}

module "service_security_group" {
  source = "../security_group"

  name   = "${var.environment}-${var.project_name}-${var.service}-load-balance"
  vpc_id = var.vpc_id
  security_groups_ingress_role = {
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
