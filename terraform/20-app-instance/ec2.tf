data "template_file" "userdata" {
  template = file("${path.module}/userdata.tpl")
}

resource "aws_instance" "nginx" {
  ami                  = data.aws_ami.amazon_linux_2.image_id
  instance_type        = "t3.micro"
  iam_instance_profile = aws_iam_instance_profile.nginx.name
  user_data            = data.template_file.userdata.rendered

  subnet_id       = element(tolist(data.aws_subnet_ids.public.ids), 0)
  security_groups = [
    aws_security_group.nginx.id
  ]

  root_block_device {
    encrypted             = true
    delete_on_termination = true
  }

  tags = merge(local.default_tags, {
    Name = var.base_name
  })
}
