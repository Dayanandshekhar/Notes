provider "aws" {
	region = "ap-southeast-1"
}

resource "aws_s3_bucket" "s3bucket-for-remotestate" {
  bucket = "s3bucket-for-remotestate-123892173"
  force_destroy = true
}

resource "aws_s3_bucket_versioning" "s3bucket-for-remotestate-versioning" {
  bucket = aws_s3_bucket.s3bucket-for-remotestate.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_dynamodb_table" "dynamodb-for-remotestate" {
  name           = "dynamodb-for-remotestate"
  billing_mode   = "PROVISIONED"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
