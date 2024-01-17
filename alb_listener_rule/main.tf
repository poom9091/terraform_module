resource "aws_lb_listener_rule" "host_based_weighted_routing" {
  lifecycle {
    ignore_changes = [
      action,
    ]
  }

  listener_arn = var.listener_arn
  priority     = var.rule_priority

  action {
    type             = "forward"
    target_group_arn = var.target_group_arn
  }

  condition {
    path_pattern {
      values = ["/*"]
    }
    # host_header {
    #   values = [var.service_domain_name]
    # }
  }
}
