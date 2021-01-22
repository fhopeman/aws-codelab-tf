resource "aws_ssm_parameter" "db_password" {
  name   = "${var.base_name}-db-password"
  type   = "SecureString" // String
  value  = "test-value"
  key_id = aws_kms_alias.ssm.name

  tags = local.default_tags
}
