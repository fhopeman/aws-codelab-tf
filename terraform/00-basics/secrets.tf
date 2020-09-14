resource "aws_ssm_parameter" "test" {
  name   = "${var.base_name}-test"
  type   = "SecureString" // String
  value  = "fabian-test-valuer"
  key_id = aws_kms_alias.ssm.name

  tags = local.default_tags
}
