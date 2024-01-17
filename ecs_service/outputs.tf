output "cluster_name" {
  value = aws_ecs_service.load_balance.cluster
}

output "service_name" {
  value = aws_ecs_service.load_balance.name
}

output "task_name" {
  value = aws_ecs_task_definition.main.arn
}

output "ecs_container_name" {
  value = "${var.environment}-${var.project_name}-${var.service}-container"
}

output "security_group_ecs_task" {
  value = module.service_security_group.securiyt_group_id
}

output "alb_target_group_arn" {
  value = var.expost == "load_balance" ? module.alb_target_group.target_group_arn : null
}


output "alb_target_group_name" {
  value = var.expost == "load_balance" ? module.alb_target_group.target_group_name : null
}

output "api_gateway_integration_id" {
  value = "null"
}
