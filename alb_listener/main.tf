resource "aws_lb_listener" "SSL" {
  lifecycle {
    ignore_changes = [
      default_action,
    ]
  }

  load_balancer_arn = var.alb_arn
  port              = var.port
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.acm_arn


  default_action {
    type             = "forward"
    target_group_arn = var.target_group_arn
  }
}
