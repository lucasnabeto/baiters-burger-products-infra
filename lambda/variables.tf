variable "cognito_user_pool_id" {
  description = "User pool ID from Cognito module"
  type        = string
}

variable "cognito_machine_client_id" {
  description = "Machine client ID from Cognito module"
  type        = string
}

variable "infra_s3_bucket_name" {
  description = "Name of the S3 bucket"
  type = string
}