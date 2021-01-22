locals {
  team        = var.base_name
  environment = "dev"

  default_tags = {
    team        = local.team
    environment = local.environment
  }
}
