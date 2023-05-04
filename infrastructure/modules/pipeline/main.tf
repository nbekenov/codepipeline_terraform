resource "aws_codepipeline" "pipeline" {
  name     = var.pipeline_name
  role_arn = var.pipeline_execution_role_arn

  artifact_store {
    location = var.s3_artifact_bucket_name
    type     = "S3"

    encryption_key {
      type = "KMS"
      id   = var.kms_key_id
    }
  }

  dynamic "stage" {
    for_each = [for stage in var.stages : {
      name    = stage.name
      actions = stage.actions
    }]
    content {
      name = stage.value.name

      dynamic "action" {
        for_each = stage.value.actions
        content {
          name             = action.value.name
          category         = action.value.category
          owner            = action.value.owner
          provider         = action.value.provider
          version          = action.value.version
          run_order        = lookup(action.value, "run_order", null)
          role_arn         = lookup(action.value, "role_arn", null)
          input_artifacts  = lookup(action.value, "input_artifacts", null)
          output_artifacts = lookup(action.value, "output_artifacts", null)
          configuration    = lookup(action.value, "configuration", null)
          region           = lookup(action.value, "region", null)
          namespace        = lookup(action.value, "namespace", null)
        }
      }
    }
  }
}
