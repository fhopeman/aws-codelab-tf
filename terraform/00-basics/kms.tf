resource "aws_kms_key" "ssm" {
  description              = "${var.base_name}-ssm"

  is_enabled               = true
  enable_key_rotation      = true
  deletion_window_in_days  = 7
}

resource "aws_kms_alias" "ssm" {
  name          = "alias/${var.base_name}-ssm"
  target_key_id = aws_kms_key.ssm.key_id
}
