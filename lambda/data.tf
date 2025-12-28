data "aws_iam_role" "lab_role" {
  name = "LabRole"
}

data "aws_s3_object" "lambda_authorizer_code" {
  bucket = var.infra_s3_bucket_name
  key    = "lambda-authorizer/lambda_authorizer.zip"
}