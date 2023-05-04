

data "archive_file" "lambda_zip" {
  type        = "zip"
  source_dir  = "${path.module}/../../src/handlers"
  output_path = "${path.module}/.terraform/archive_files/lambda.zip"
}


resource "aws_lambda_function" "example_lambda" {
  #checkov:skip=CKV_AWS_50: "X-ray tracing is enabled for Lambda" - N/A
  #checkov:skip=CKV_AWS_116: "Ensure that AWS Lambda function is configured for a Dead Letter Queue(DLQ)" - N/A
  #checkov:skip=CKV_AWS_117: "Ensure that AWS Lambda function is configured inside a VPC" - not accessing any data from AWS
  description                    = "example lambda for ${local.config["environment"]} environment"
  filename                       = "${path.module}/.terraform/archive_files/lambda.zip"
  function_name                  = "${local.config["environment"]}-example-lambda"
  role                           = aws_iam_role.iam_for_example_lambda.arn
  handler                        = "app.lambda_handler"
  source_code_hash               = data.archive_file.lambda_zip.output_base64sha256
  runtime                        = "python3.9"
  reserved_concurrent_executions = 100

  environment {
    variables = {
      ACCOUNT_ID = data.aws_caller_identity.current.account_id
    }
  }

}

resource "aws_iam_role" "iam_for_example_lambda" {
  name               = "${local.config["environment"]}-example-lambda"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

}

resource "aws_iam_role_policy" "example_lambda_role_policy" {
  name   = "${local.config["environment"]}-example-lambda-role_policy"
  role   = aws_iam_role.iam_for_example_lambda.id
  policy = data.aws_iam_policy_document.example_lambda_policy_document.json
}

data "aws_iam_policy_document" "example_lambda_policy_document" {
  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:DescribeLogStreams",
    ]

    resources = [
      "arn:aws:logs:*:*:*",
    ]
  }
}