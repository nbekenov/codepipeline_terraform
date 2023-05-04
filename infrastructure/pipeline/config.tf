locals {

  default_tags = {
    "demo.environment" = local.config["environment"]
    "demo.automation"  = "terraform"
    "demo.project"     = local.config["project_name"]
    "demo.component"   = "pipeline"
  }

  config = {
    profile      = "default"
    region       = "us-east-1"
    environment  = "dev"
    project_name = "terraform-cicd"
  }

  resource_prefix = "${local.config["project_name"]}-${local.config["region"]}"

}