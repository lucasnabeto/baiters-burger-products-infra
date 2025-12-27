data "aws_iam_role" "lab_role" {
  name = "LabRole"
}

data "aws_s3_object" "lambda_authorizer_code" {
  bucket = "baitersburger-products-infra"
  key    = "lambda-authorizer/lambda_authorizer.zip"
}