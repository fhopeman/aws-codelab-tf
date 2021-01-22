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

  tags = merge(local.default_tags, {
    Name = var.base_name
  })
}

#resource "aws_launch_configuration" "this" {
#  name_prefix                 = "${var.base_name}-"
#  image_id                    = data.aws_ami.amazon_linux_2.image_id
#  instance_type               = var.instance_type
#  user_data                   = data.template_file.userdata.rendered
#  associate_public_ip_address = false
#  iam_instance_profile        = aws_iam_instance_profile.nginx.arn
#
#   security_groups             = [
#    aws_security_group.nginx.id
#  ]
#
#  lifecycle {
#    create_before_destroy = true
#  }
#}

#resource "aws_autoscaling_group" "this" {
#  name_prefix               = "${var.base_name}-${aws_launch_configuration.this.name}-"
#  launch_configuration      = aws_launch_configuration.this.name
#  min_size                  = 1
#  desired_capacity          = 1
#  max_size                  = 1
#  health_check_type         = "ELB"
#  health_check_grace_period = 120
#  vpc_zone_identifier       = data.aws_subnet_ids.private.ids
#
#  load_balancers = [
#    aws_elb.yocto.name
#  ]
#
#  tags = [
#    {
#    key = "Name"
#      value = "${var.base_name}-yocto"
#      propagate_at_launch = true
#    }
#  ]
#
#  lifecycle {
#    create_before_destroy = true
#  }
#}
