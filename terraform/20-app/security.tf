resource "aws_security_group" "ec2_instance" {
  name   = "${var.base_name}-ec2-instance"
  vpc_id = data.aws_vpc.this.id

  ingress {
    protocol  = "tcp"
    from_port = 8080
    to_port   = 8080

    cidr_blocks = [
      var.my_ip_cidr
    ]
  }

  egress {
    protocol  = "-1"
    from_port = 0
    to_port   = 0

    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }
}


resource "aws_security_group" "elb" {
  name   = "${var.base_name}-elb"
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
    protocol  = "-1"
    from_port = 0
    to_port   = 0

    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }
}
