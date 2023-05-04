###############################################################################
# S3 Bucket for Terraform state
###############################################################################
resource "aws_s3_bucket" "state" {
  bucket        = local.config["s3_bucket_name"]
  force_destroy = true
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.state.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "server_side_encryption" {
  bucket = aws_s3_bucket.state.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

###############################################################################
# Dynamodb for acquiring state lock
###############################################################################

resource "aws_dynamodb_table" "terraform-lock" {
  name           = local.config["dynamodb_table_name"]
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
  tags = {
    "Name" = "DynamoDB Terraform State Lock Table"
  }
}