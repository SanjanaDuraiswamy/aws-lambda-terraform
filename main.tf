# Lambda module
module "lambda" {
  source        = "./modules/lambda"
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
# EC2 module — TESTING BOUNDARY — should FAIL!
module "ec2" {
  source        = "./modules/ec2"
  instance_name = var.ec2_instance_name
  tags          = var.tags
} 