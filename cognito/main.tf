resource "aws_cognito_user_pool" "user_pool_configuration" {
  name                     = "BaitersBurgerProducts_CognitoUserPool"
  auto_verified_attributes = []
  mfa_configuration        = "OFF"

  username_configuration {
    case_sensitive = false
  }

  password_policy {
    minimum_length = 8
  }
}

resource "aws_cognito_resource_server" "resource_server" {
  name         = "BaitersBurgerProductsAPI"
  identifier   = "baitersburger-products"
  user_pool_id = aws_cognito_user_pool.user_pool_configuration.id

  scope {
    scope_name        = "crud"
    scope_description = "Permission to crud-products operations"
  }
}

resource "aws_cognito_user_pool_client" "machine_client" {
  name         = "BaitersBurgerProductsMachineClient"
  user_pool_id = aws_cognito_user_pool.user_pool_configuration.id

  generate_secret                      = true
  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_flows                  = ["client_credentials"]
  allowed_oauth_scopes = [
    "${aws_cognito_resource_server.resource_server.identifier}/crud",
  ]

  access_token_validity = 60
  id_token_validity = 60
  refresh_token_validity = 30
  token_validity_units {
    access_token = "minutes"
    id_token = "minutes"
    refresh_token = "days"
  }
}

resource "aws_cognito_user_pool_domain" "this" {
  domain       = "baitersburger-products-application"
  user_pool_id = aws_cognito_user_pool.user_pool_configuration.id
}
