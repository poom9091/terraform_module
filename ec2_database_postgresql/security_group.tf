module "database_security_group" {
  source = "../security_group"

  name   = "${var.environment}-${var.server_name}"
  vpc_id = var.vpc_id
  security_groups_ingress_role = {
    Postgres = {
      protocal   = "tcp"
      from_port  = 5432
      to_port    = 5432
      cidr_block = ["0.0.0.0/0"]
    }
  }
}
