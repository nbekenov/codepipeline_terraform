locals {

  default_tags = {
    "apg.environment" = local.config["environment"]
    "apg.automation"  = "terraform"
    "apg.project"     = "terraform_cicd"
    "apg.component"   = "bootstrap"
  }

  config = {
    profile             = "dev"
    region              = "us-east-1"
    environment         = "dev"
    dynamodb_table_name = "terraform-state"
    s3_bucket_name      = "demo-terraform-state-us-east-1"
  }

}