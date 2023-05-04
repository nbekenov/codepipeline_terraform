terraform {
  backend "s3" {
    region         = "us-east-1"
    profile        = "default"
    bucket         = "demo-apg-terraform-state-us-east-1"
    key            = "terraform_cicd/pipeline.tfstate"
    encrypt        = "true"
    dynamodb_table = "terraform-state"
  }
}