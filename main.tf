module "aws_ecr_ecs" {
  source = "./ecr-ecs"
}

module "aws_rds" {
  source = "./rds"

  vpc_default = data.aws_vpc.vpc_default.id
  subnets     = data.aws_subnets.all_default_subnets.ids
}

module "aws_cognito" {
  source = "./cognito"

  cognito_domain_prefix = "baitersburger-products-app"
}

module "aws_lambda" {
  source     = "./lambda"
  depends_on = [module.aws_cognito]

  cognito_user_pool_id      = module.aws_cognito.cognito_user_pool_id
  cognito_machine_client_id = module.aws_cognito.cognito_machine_client_id
  infra_s3_bucket_name = data.aws_s3_bucket.baitersburger-products-s3-bucket.id
}

module "aws_elb" {
  source = "./elb"

  infra_s3_bucket = data.aws_s3_bucket.baitersburger-products-s3-bucket.id
  vpc_default     = data.aws_vpc.vpc_default.id
  subnets         = data.aws_subnets.all_default_subnets.ids
}