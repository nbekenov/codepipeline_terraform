locals {

  valid_workspaces = {
    dev  = "dev"
    prod = "prod"
  }

  selected_workspace = local.valid_workspaces[terraform.workspace]

  default_tags = {
    "apg.environment" = local.config["environment"]
    "apg.automation"  = "terraform"
    "apg.project"     = "apg-terraform-cicd"
    "apg.component"   = "lambda"
  }

  config = local.environment_config[local.selected_workspace]

  environment_config = {
    dev  = local.dev
    prod = local.prod
  }
}