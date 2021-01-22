resource "aws_security_group" "nginx" {
  name   = "${var.base_name}-nginx"
  vpc_id = data.aws_vpc.this.id

  ingress {
    protocol  = "tcp"
    from_port = 80
    to_port   = 80

    cidr_blocks = [
      var.my_ip_cidr,
      data.aws_vpc.this.cidr_block
    ]
  }

  egress {
    protocol  = "tcp"
    from_port = 443
    to_port   = 443

    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

  egress {
    protocol  = "tcp"
    from_port = 80
    to_port   = 80

    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

  tags = local.default_tags
}
