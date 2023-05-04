output "stage" {
  value = {
    name = "Source"

    actions = concat(
      [{
        name             = "Source"
        category         = "Source"
        owner            = "AWS"
        provider         = "CodeCommit"
        version          = "1"
        run_order        = 1
        input_artifacts  = null
        output_artifacts = ["SourceZip"]
        role_arn         = null
        namespace        = null
        region           = null
        configuration = {
          BranchName           = var.branch_name
          PollForSourceChanges = false
          RepositoryName       = data.aws_codecommit_repository.repository.repository_name
          OutputArtifactFormat = "CODEBUILD_CLONE_REF"
        }

      }],
    )
  }
}

output "aws_codecommit_repository" {
  description = "Object from terraform aws_codecommit_repository resource."
  value       = data.aws_codecommit_repository.repository.arn
}