variable "repository_name" {
  type        = string
  description = "repository name"
}

variable "branch_name" {
  type        = string
  description = "Pipeline branch name"
  default     = "main"
}

variable "codebuild_role_name" {
  type        = set(string)
  description = "(Optional) IAM Role used by CodeBuild.  Grants permission to CodeCommit repository."
  default     = []
}

variable "pipeline_role_name" {
  type        = string
  description = "Pipeline role name."
}
