# module "listener_rule_main" {
#   source = "../alb_listener_rule"
#   # count               = var.listener_arn_main == null ? 0 : 1
#   listener_arn        = var.listener_arn_main
#   target_group_arn    = module.alb_target_group.target_group_arn
#   service_domain_name = var.service_domain_name
#   rule_priority       = var.rule_priority
# }


module "alb_target_group" {
  source = "../alb_target_group"

  project_name      = var.project_name
  environment       = var.environment
  service           = var.service
  vpc_id            = var.vpc_id
  port              = var.container_port
  protocol          = "TCP"
  health_check_path = var.health_check_path
}


resource "aws_ecs_service" "load_balance" {
  name                               = "${var.environment}-${var.project_name}-${var.service}"
  cluster                            = var.cluster_id
  task_definition                    = aws_ecs_task_definition.main.arn
  desired_count                      = var.desired_count
  deployment_minimum_healthy_percent = var.deployment_minimum_healthy_percent
  deployment_maximum_percent         = var.deployment_maximum_percent
  force_new_deployment               = true
  launch_type                        = "FARGATE"

  network_configuration {
    subnets         = var.subnets
    security_groups = [module.service_security_group.securiyt_group_id]
  }

  lifecycle {
    ignore_changes = [desired_count, load_balancer]
  }

  deployment_circuit_breaker {
    enable   = true
    rollback = true
  }
  deployment_controller {
    type = "ECS"
  }

  dynamic "load_balancer" {
    for_each = var.expost == "load_balance" ? [{
      container_name   = "${var.environment}-${var.project_name}-${var.service}-container"
      container_port   = var.container_port
      target_group_arn = module.alb_target_group.target_group_arn
    }] : []
    content {
      container_name   = load_balancer.value["container_name"]
      container_port   = load_balancer.value["container_port"]
      target_group_arn = load_balancer.value["target_group_arn"]
    }
  }

  service_registries {
    registry_arn = aws_service_discovery_service.service.arn
    # container_port = var.container_port
    container_name = "${var.environment}-${var.project_name}-${var.service}-container"
  }
}

resource "aws_service_discovery_service" "service" {
  name = var.service

  dns_config {
    namespace_id = var.cloudmap_id

    dns_records {
      ttl  = 60
      type = "A"
    }

    routing_policy = "WEIGHTED"
  }

  health_check_custom_config {
    failure_threshold = 1
  }
}
