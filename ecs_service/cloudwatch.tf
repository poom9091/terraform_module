resource "aws_cloudwatch_log_group" "main" {
  name              = "/ecs/${var.environment}-${var.project_name}-${var.service}"
  retention_in_days = var.logs_retention_in_days
  tags = {
    # environment = var.environment
    application = var.project_name
  }
}

resource "aws_cloudwatch_log_stream" "main" {
  name           = "${var.environment}-${var.project_name}-${var.service}-log-stream"
  log_group_name = aws_cloudwatch_log_group.main.name
}

resource "aws_cloudwatch_log_group" "sidercar_container" {
  name              = "/ecs/${var.environment}-${var.service}-app-mesh"
  retention_in_days = 1
  tags = {
    # environment = var.environment
    application = var.project_name
  }
}

resource "aws_cloudwatch_log_stream" "sidercar_container" {
  name           = "${var.environment}-${var.project_name}-${var.service}-app-mesh"
  log_group_name = aws_cloudwatch_log_group.sidercar_container.name
}

resource "aws_cloudwatch_log_group" "otle_container" {
  name              = "/ecs/${var.environment}-${var.service}-otel"
  retention_in_days = 1
  tags = {
    # environment = var.environment
    application = var.project_name
  }
}

resource "aws_cloudwatch_log_stream" "otel_container" {
  name           = "${var.environment}-${var.service}-otel"
  log_group_name = aws_cloudwatch_log_group.otle_container.name
}
