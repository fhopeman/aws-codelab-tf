data "template_file" "userdata" {
  template = file("${path.module}/userdata.tpl")
}

resource "aws_launch_configuration" "this" {
  name_prefix                 = "${var.base_name}-"
  image_id                    = data.aws_ami.amazon_linux_2.image_id
  instance_type               = "t3.micro"
  user_data                   = data.template_file.userdata.rendered
  iam_instance_profile        = aws_iam_instance_profile.nginx.arn

  security_groups             = [
    aws_security_group.nginx.id
  ]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "this" {
  name_prefix               = "${var.base_name}-${aws_launch_configuration.this.name}-"
  launch_configuration      = aws_launch_configuration.this.name
  min_size                  = 2
  desired_capacity          = 2
  max_size                  = 2
  health_check_type         = "ELB"
  health_check_grace_period = 120
  vpc_zone_identifier       = data.aws_subnet_ids.private.ids

  target_group_arns = [aws_lb_target_group.service1.arn]

  tags = [
    {
    key = "Name"
      value = "${var.base_name}-nginx"
      propagate_at_launch = true
    }
  ]

  lifecycle {
    create_before_destroy = true
  }
}
