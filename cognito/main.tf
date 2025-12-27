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
    scope_name        = "crud-products"
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
    "${aws_cognito_resource_server.resource_server.identifier}/crud-products",
  ]
}