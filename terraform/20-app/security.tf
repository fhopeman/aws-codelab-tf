resource "aws_security_group" "yocto" {
  name   = "${var.base_name}-yocto"
  vpc_id = data.aws_vpc.this.id

  ingress {
    protocol  = "tcp"
    from_port = 8080
    to_port   = 8080

    cidr_blocks = [
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
}

resource "aws_security_group" "yocto_elb" {
  name   = "${var.base_name}-yocto-elb"
  vpc_id = data.aws_vpc.this.id

  ingress {
    protocol  = "tcp"
    from_port = 80
    to_port   = 80

    cidr_blocks = [
      var.my_ip_cidr
    ]
  }

  egress {
    protocol  = "tcp"
    from_port = 8080
    to_port   = 8080

    cidr_blocks = [
      data.aws_vpc.this.cidr_block
    ]
  }
}
