terraform {
  backend "s3" {
    region         = "us-east-1"
    profile        = "default"
    bucket         = "demo-terraform-state-us-east-1"
    key            = "terraform_cicd/lambda.tfstate"
    encrypt        = "true"
    dynamodb_table = "terraform-state"
  }
}