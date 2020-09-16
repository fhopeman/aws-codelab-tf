resource "aws_elb" "yocto" {
  name = "${var.base_name}-yocto"
  subnets = data.aws_subnet_ids.public.ids

  security_groups = [
    aws_security_group.yocto_elb.id
  ]

  listener {
    lb_protocol = "http"
    lb_port = 80
    instance_protocol = "http"
    instance_port = 8080
  }

  health_check {
    healthy_threshold = 2
    interval = 5
    target = "HTTP:8080/status"
    timeout = 2
    unhealthy_threshold = 2
  }
}
