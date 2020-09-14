resource "aws_elb" "yocto" {
  name = "${var.team_name}-yocto-elb"
  subnets = ["${aws_subnet.publicsubnets.*.id}"]
  security_groups = ["${aws_security_group.elb.id}"]
  listener {
    instance_port = 8080
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }
  health_check {
    healthy_threshold = 2
    interval = 5
    target = "HTTP:8080/status"
    timeout = 2
    unhealthy_threshold = 2
  }
}
