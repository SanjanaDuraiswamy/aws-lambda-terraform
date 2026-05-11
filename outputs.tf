output "lambda_function_name" {
  description = "Name of the deployed Lambda function"
  value       = module.lambda.function_name
}

output "lambda_arn" {
  description = "ARN of the deployed Lambda function"
  value       = module.lambda.lambda_arn
}