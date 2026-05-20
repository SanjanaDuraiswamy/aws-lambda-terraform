module "lambda" {
  source        = "./modules/lambda"
  function_name = var.function_name
  filename      = "lambda.zip"
  handler       = var.handler
  runtime       = var.runtime
  timeout       = var.timeout
  memory_size   = var.memory_size
  tags          = var.tags
}