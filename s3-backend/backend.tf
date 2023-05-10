

resource "aws_s3_bucket" "tf_s3_state" {
  bucket = "tf-s3-state-moodytf"
  
  force_destroy = true
}

resource "aws_s3_bucket_versioning" "tf_s3_state_versioning"{
    bucket = aws_s3_bucket.tf_s3_state.bucket
    versioning_configuration {
    status = "Enabled"
  }
}
resource "aws_s3_bucket_server_side_encryption_configuration" "tf_s3_state_encryption" {
  bucket = aws_s3_bucket.tf_s3_state.bucket

  rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
    }
  }
}
output "s3-arn" {
      value = aws_s3_bucket.tf_s3_state.arn
  }

output "s3-bucket-name" {
      value = aws_s3_bucket.tf_s3_state.bucket
  }


resource "aws_dynamodb_table" "tf_dynmodb_state_lock" {
  hash_key = "LockID"
  name = "tf_dynmodb_state_lock"
  attribute {
    name = "LockID"
    type = "S"
  }
billing_mode = "PAY_PER_REQUEST"
}