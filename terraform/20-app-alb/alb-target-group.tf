resource "aws_lb_target_group" "service1" {
  name     = "${var.base_name}-service1"
  protocol = "HTTP"
  port     = 80
  vpc_id   = data.aws_vpc.this.id

  deregistration_delay = 10
  health_check {
    timeout  = 3
    interval = 5
    port     = 80
    path     = "/service1/health"
    protocol = "HTTP"
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = merge(local.default_tags, {
    Name = var.base_name
  })
}

resource "aws_lb_listener_rule" "service1" {
  listener_arn = aws_lb_listener.this.arn

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.service1.arn
  }

  condition {
    path_pattern {
      values = ["/service1/*"]
    }
  }
}
