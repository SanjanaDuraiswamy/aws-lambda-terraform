aws_region      = "us-east-1"
function_name   = "brillio-coe-lambda"
lambda_role_arn = "arn:aws:iam::060118751555:role/your-lambda-exec-role"
handler         = "lambda-fun.handler"
runtime         = "python3.12"
timeout         = 30
memory_size     = 256

tags = {
  Name           = "brillio-coe-lambda"
  Owner          = "Sanjana D"
  ContactEmail   = "sanjana.d@brillio.com"
  Application    = "brillio-coe"
  Project        = "aws-resources-provisioning"
  ProjectEndDate = "2026-12-31"
}