data "aws_vpc" "this" {
  tags = {
    Name = var.base_name
  }
}

data "aws_subnet_ids" "public" {
  vpc_id = data.aws_vpc.this.id
  tags = {
    tier = "public"
  }
}

data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-ebs"]
  }
}
