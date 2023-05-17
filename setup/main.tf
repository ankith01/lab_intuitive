# Define a s3 bucket to store terraform state file.
resource "aws_s3_bucket" "terraform_state" {
  bucket        = format("terraform2-state-%s", local.region)
  force_destroy = false
  lifecycle {
    ignore_changes = [bucket]
  }
  tags = {
    "Region" : local.region
    "Environment" : "Lab-Test"
    "Project" : "Infrastructure"
  }
}

#### S3 bucket access_block
resource "aws_s3_bucket_public_access_block" "terraform_state" {
  bucket                  = aws_s3_bucket.terraform_state.id
  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
  ignore_public_acls      = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.bucket
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}