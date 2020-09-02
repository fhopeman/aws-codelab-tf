resource "aws_ssm_parameter" "test" {
  name   = "${var.base_name}-test"
  type   = "SecureString" // String
  value  = "fabian-test-valuer"
  key_id = aws_kms_alias.ssm.target_key_id

  tags = local.default_tags
}
