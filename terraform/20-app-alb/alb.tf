resource "aws_lb" "this" {
  name                             = var.base_name
  load_balancer_type               = "application"
  internal                         = false
  enable_cross_zone_load_balancing = true

  subnets         = data.aws_subnet_ids.public.ids
  security_groups = [aws_security_group.alb.id]

  tags = merge(local.default_tags, {
    Name = var.base_name
  })
}

resource "aws_lb_listener" "this" {
  load_balancer_arn = aws_lb.this.arn
  protocol          = "HTTP"
  port              = "80"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "default response"
      status_code  = "200"
    }
  }
}
