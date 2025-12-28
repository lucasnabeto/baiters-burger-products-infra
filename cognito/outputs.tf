output "cognito_user_pool_id" {
  description = "User pool ID"
  value       = aws_cognito_user_pool.user_pool_configuration.id
}

output "cognito_machine_client_id" {
  description = "Machine client ID"
  value       = aws_cognito_user_pool_client.machine_client.id
}