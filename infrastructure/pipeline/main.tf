
################################################################################
# Source - existing codeCommit repo
################################################################################
module "source_codecommit" {
  source = "../modules/codecommit"

  repository_name    = "terraform_cicd_pipeline"
  branch_name        = var.branch_name
  pipeline_role_name = aws_iam_role.codepipeline_role.name
  codebuild_role_name = flatten(
    [
      aws_iam_role.codebuild_role.name
    ]
  )
}

module "self_mutate" {
  source = "../modules/codebuild"

  name                                    = "${local.resource_prefix}-self_mutate_project"
  stage_name                              = "Self-Mutate"
  codebuild_role_arn                      = aws_iam_role.codebuild_role.arn
  source_buildspec                        = "self_mutate_buildspec.yaml"
  kms_key_id                              = aws_kms_key.kms_key.arn
  environment_privileged_mode             = var.environment_privileged_mode
  environment_image                       = var.environment_image
  environment_compute_type                = var.environment_compute_type
  environment_type                        = var.environment_type
  environment_image_pull_credentials_type = var.environment_image_pull_credentials_type
  action_output_artifact_name             = "BuiltZip_self_mutate"
  environment_variables = [
    ({ name = "ENV_NAME", value = "dev", type = "PLAINTEXT" })
  ]

}

module "build_app" {
  source = "../modules/codebuild"

  name                                    = "${local.resource_prefix}-build_app_project"
  stage_name                              = "Build-App"
  codebuild_role_arn                      = aws_iam_role.codebuild_role.arn
  source_buildspec                        = "buildspec.yaml"
  kms_key_id                              = aws_kms_key.kms_key.arn
  environment_privileged_mode             = var.environment_privileged_mode
  environment_image                       = var.environment_image
  environment_compute_type                = var.environment_compute_type
  environment_type                        = var.environment_type
  environment_image_pull_credentials_type = var.environment_image_pull_credentials_type
  environment_variables = [
    ({ name = "ENV_NAME", value = "dev", type = "PLAINTEXT" })
  ]

}

module "tf_plan_dev" {
  source = "../modules/codebuild"

  name                                    = "${local.resource_prefix}-tf_plan_dev"
  stage_name                              = "Validate-IaC-DEV"
  codebuild_role_arn                      = aws_iam_role.codebuild_role.arn
  source_buildspec                        = var.terraform_buildspec
  kms_key_id                              = aws_kms_key.kms_key.arn
  environment_privileged_mode             = var.environment_privileged_mode
  environment_image                       = var.environment_image
  environment_compute_type                = var.environment_compute_type
  environment_type                        = var.environment_type
  environment_image_pull_credentials_type = var.environment_image_pull_credentials_type
  action_output_artifact_name             = "BuiltZip_tf_plan"
  environment_variables = [
    ({ name = "ENV_NAME", value = "dev", type = "PLAINTEXT" })
  ]

}

module "tf_apply_dev" {
  source = "../modules/codebuild"

  name                                    = "${local.resource_prefix}-tf_apply_dev"
  stage_name                              = "Deploy-IaC-DEV"
  codebuild_role_arn                      = aws_iam_role.codebuild_role.arn
  source_buildspec                        = var.terraform_buildspec_apply
  kms_key_id                              = aws_kms_key.kms_key.arn
  environment_privileged_mode             = var.environment_privileged_mode
  environment_image                       = var.environment_image
  environment_compute_type                = var.environment_compute_type
  environment_type                        = var.environment_type
  environment_image_pull_credentials_type = var.environment_image_pull_credentials_type
  action_output_artifact_name             = "BuiltZip_tf_apply"
  environment_variables = [
    ({ name = "ENV_NAME", value = "dev", type = "PLAINTEXT" })
  ]

}

module "pipeline" {
  source = "../modules/pipeline"

  pipeline_name               = "terraform-cicd-pipeline"
  pipeline_execution_role_arn = aws_iam_role.codepipeline_role.arn
  s3_artifact_bucket_name     = aws_s3_bucket.artifact_bucket.bucket
  kms_key_id                  = aws_kms_key.kms_key.id
  stages = [
    module.source_codecommit.stage,
    module.self_mutate.stage,
    module.build_app.stage,
    module.tf_plan_dev.stage,
    module.tf_apply_dev.stage
  ]
}