module "aws_ecr_ecs" {
  source = "./ecr-ecs"
}

module "aws_rds" {
  source = "./rds"
}

module "aws_cognito" {
  source = "./cognito"

  cognito_domain_prefix = "baitersburger-products-app"
}

module "aws_lambda" {
  source     = "./lambda"
  depends_on = [module.aws_cognito]

  cognito_user_pool_id        = module.aws_cognito.cognito_user_pool_id
  cognito_machine_client_id   = module.aws_cognito.cognito_machine_client_id
}