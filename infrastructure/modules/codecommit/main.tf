
data "aws_codecommit_repository" "repository" {
  repository_name = var.repository_name
}


data "aws_iam_policy_document" "codecommit_role" {
  statement {
    actions = [
      "codecommit:CancelUploadArchive",
      "codecommit:GetBranch",
      "codecommit:GetCommit",
      "codecommit:GetRepository",
      "codecommit:GetUploadArchiveStatus",
      "codecommit:GitPull",
      "codecommit:ListBranches",
      "codecommit:UploadArchive",
    ]

    resources = [data.aws_codecommit_repository.repository.arn]
  }
}


resource "aws_iam_role_policy" "codebuild_codecommit" {
  for_each = var.codebuild_role_name
  name     = "${var.repository_name}-codebuild-codecommit"
  role     = each.value
  policy   = data.aws_iam_policy_document.codecommit_role.json
}

resource "aws_iam_role_policy" "pipeline_codecommit" {
  name   = "${var.repository_name}-pipeline-codecommit"
  role   = var.pipeline_role_name
  policy = data.aws_iam_policy_document.codecommit_role.json
}