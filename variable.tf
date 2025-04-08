variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
}

variable "s3_bucket_name" {
  description = "The name of the S3 bucket to store the Terraform state"
  type        = string
}

variable "dynamodb_table_name" {
  description = "The name of the DynamoDB table used for state locking"
  type        = string
}

variable "environment" {
  description = "The deployment environment (e.g., dev, staging, prod)"
  type        = string
}
