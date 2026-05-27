# Get current AWS account ID
data "aws_caller_identity" "current" {}

# IAM module — OIDC provider, roles, boundary
module "iam" {
  source = "./iam"
}

# Lambda module
module "lambda" {
  source        = "./modules/lambda"
  account_id    = data.aws_caller_identity.current.account_id
  function_name = var.function_name
  filename      = "lambda.zip"
  handler       = var.handler
  runtime       = var.runtime
  timeout       = var.timeout
  memory_size   = var.memory_size
  bucket_name   = aws_s3_bucket.data_bucket.id
  tags          = var.tags
}

# Glue module
module "glue" {
  source          = "./modules/glue"
  job_name        = var.glue_job_name
  script_location = "s3://${aws_s3_bucket.data_bucket.id}/scripts/glue-job.py"
  bucket_name     = aws_s3_bucket.data_bucket.id
  tags            = var.tags
}