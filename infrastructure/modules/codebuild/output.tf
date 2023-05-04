output "stage" {
  value = {
    name = var.stage_name

    actions = [{
      name             = "CodeBuild"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      version          = "1"
      run_order        = null
      input_artifacts  = [var.action_input_artifact_name]
      output_artifacts = [var.action_output_artifact_name]
      role_arn         = null
      namespace        = null
      region           = null

      configuration = {
        ProjectName = aws_codebuild_project.main.name
      }
    }]
  }
}

output "codebuild_project" {
  description = "The CodeBuild project."
  value       = aws_codebuild_project.main
}
