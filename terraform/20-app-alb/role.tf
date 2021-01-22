resource "aws_iam_role" "nginx" {
  name = "${var.base_name}-nginx"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      }
    }
  ]
}
EOF
}

resource "aws_iam_policy_attachment" "nginx_ssm" {
  name       = "${var.base_name}-yocto-ssm"
  roles      = [aws_iam_role.nginx.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "nginx" {
  name = "${var.base_name}-nginx"
  role = aws_iam_role.nginx.id
}
