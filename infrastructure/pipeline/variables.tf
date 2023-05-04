variable "terraform_buildspec" {
  type        = string
  default     = "terraform_plan_buildspec.yaml"
  description = "Buildspec used by terraform"
}

variable "terraform_buildspec_apply" {
  type        = string
  default     = "terraform_apply_buildspec.yaml"
  description = "Buildspec used by terraform"
}

variable "branch_name" {
  type        = string
  description = "Pipeline branch name"
  default     = "main"
}

variable "environment_privileged_mode" {
  type        = bool
  default     = null
  description = "(Optional) If set to true, enables running the Docker daemon inside a Docker container. Defaults to false."
}

variable "environment_image" {
  type        = string
  default     = "aws/codebuild/amazonlinux2-x86_64-standard:3.0"
  description = "(Required) The Docker image to use for this build project. Valid values include Docker images provided by CodeBuild (e.g aws/codebuild/standard:2.0), Docker Hub images (e.g. hashicorp/terraform:latest), and full Docker repository URIs such as those for ECR (e.g. 137112412989.dkr.ecr.us-west-2.amazonaws.com/amazonlinux:latest)."
}

variable "environment_compute_type" {
  type        = string
  default     = "BUILD_GENERAL1_SMALL"
  description = "(Required) Information about the compute resources the build project will use. Available values for this parameter are: BUILD_GENERAL1_SMALL, BUILD_GENERAL1_MEDIUM or BUILD_GENERAL1_LARGE. BUILD_GENERAL1_SMALL is only valid if type is set to LINUX_CONTAINER."
}

variable "environment_type" {
  type        = string
  default     = "LINUX_CONTAINER"
  description = "(Required) The type of build environment to use for related builds. Available values are: LINUX_CONTAINER or WINDOWS_CONTAINER."
}

variable "environment_image_pull_credentials_type" {
  type        = string
  default     = null
  description = "(Optional) The type of credentials AWS CodeBuild uses to pull images in your build. Available values for this parameter are `CODEBUILD` or `SERVICE_ROLE`. When you use a cross-account or private registry image, you must use `SERVICE_ROLE` credentials. When you use an AWS CodeBuild curated image, you must use `CODEBUILD` credentials. Default to `CODEBUILD`."
}