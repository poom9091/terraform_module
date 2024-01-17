module "service_security_group" {
  source = "../security_group"

  name                         = "${var.environment}-${var.project_name}-${var.service}-sg-task"
  vpc_id                       = var.vpc_id
  security_groups_ingress_role = var.security_group_ecs_task
}
