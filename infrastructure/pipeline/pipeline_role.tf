resource "aws_iam_role" "codepipeline_role" {
  name = "${local.resource_prefix}-codepipeline_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codepipeline.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "codepipeline_policy" {
  name = "${local.resource_prefix}-codepipeline_policy"
  role = aws_iam_role.codepipeline_role.name

  policy = templatefile("${path.module}/templates/codepipeline_policy.json.tpl",
    {
      cmk_arn             = aws_kms_key.kms_key.arn
      artifact_bucket_arn = aws_s3_bucket.artifact_bucket.arn
      partition           = data.aws_partition.current.partition
      region              = data.aws_region.current.name
      account_id          = data.aws_caller_identity.current.account_id
      project_name        = local.config["project_name"]
  })
}