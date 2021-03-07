provider "aws" {
  region = "us-east-1"
}

terraform {
  required_providers {
   aws = {
         source = "hashicorp/aws"
         version = ">=3.31.0"
   }
  }

  backend "s3" {
    key = "global/s3/terraform.tfstate"
  }
}

resource "aws_s3_bucket" "tf_remote_backend" {
  bucket = "hari-tf-remote-backend"

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  logging {
    target_bucket = aws_s3_bucket.tf_remote_backend_bucket_logs.id
    target_prefix = "log/"
  }
}

resource "aws_s3_bucket" "tf_remote_backend_bucket_logs" {
  bucket = "tf-remote-backend-bucket-logs"
  acl = "log-delivery-write"

  versioning {
    enabled = true
  }

  lifecycle {
    create_before_destroy = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_dynamodb_table" "terraform_locks" {
  name         = "tf-remote-backend-lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

output "s3_bucket_arn" {
  value       = aws_s3_bucket.tf_remote_backend.arn
  description = "The ARN of the S3 bucket"
}

output "dynamodb_table_name" {
  value       = aws_dynamodb_table.terraform_locks.name
  description = "The name of the DynamoDB table"
}
