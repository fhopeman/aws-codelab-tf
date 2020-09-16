resource "aws_iam_role" "yocto" {
  name = "${var.base_name}-yocto"

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

resource "aws_iam_policy_attachment" "yocto_ssm" {
  name       = "${var.base_name}-yocto-ssm"
  roles      = [aws_iam_role.yocto.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "yocto" {
  name = "${var.base_name}-yocto"
  role = aws_iam_role.yocto.id
}
