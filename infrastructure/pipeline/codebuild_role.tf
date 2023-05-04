resource "aws_iam_role" "codebuild_role" {
  name = "${local.resource_prefix}-codebuild_deploy_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codebuild.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "codebuild_policy" {
  name = "${local.resource_prefix}_codebuild_deployment_policy"
  role = aws_iam_role.codebuild_role.name

  policy = templatefile("${path.module}/templates/codebuild_policy.json.tpl",
    {
      cmk_arn             = aws_kms_key.kms_key.arn
      artifact_bucket_arn = aws_s3_bucket.artifact_bucket.arn
      partition           = data.aws_partition.current.partition
      region              = data.aws_region.current.name
      account_id          = data.aws_caller_identity.current.account_id
      project_name        = local.config["project_name"]
  })
}


# temp attach Admin
data "aws_iam_policy" "AdministratorAccess" {
  arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_role_policy_attachment" "admin-role-policy-attach" {
  role       = aws_iam_role.codebuild_role.name
  policy_arn = data.aws_iam_policy.AdministratorAccess.arn
}