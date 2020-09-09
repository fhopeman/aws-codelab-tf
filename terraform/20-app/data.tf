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

data "aws_subnet_ids" "private" {
  vpc_id = data.aws_vpc.this.id
  tags = {
    tier = "private"
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

#resource "aws_ami_copy" "amazon_linux_2_encrypted" {
#  name              = "${data.aws_ami.amazon_linux_2.name}-encrypted"
#  description       = "${data.aws_ami.amazon_linux_2.description} (encrypted)"
#  source_ami_id     = data.aws_ami.amazon_linux_2.id
#  source_ami_region = var.region
#  encrypted         = true
#
#  tags = {
#    ImageType      = "encrypted-amzn2-linux"
#  }
#}
