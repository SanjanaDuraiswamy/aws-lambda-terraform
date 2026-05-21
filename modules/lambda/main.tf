# Lambda execution role
resource "aws_iam_role" "lambda_exec" {
  name                 = "${var.function_name}-exec-role"
  permissions_boundary = "arn:aws:iam::${var.account_id}:policy/github-oidc-boundary"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = { Service = "lambda.amazonaws.com" }
      Action    = "sts:AssumeRole"
    }]
  })

  tags = var.tags
}

# Attach Lambda basic execution policy
resource "aws_iam_role_policy_attachment" "lambda_basic" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# Attach S3 full access policy
resource "aws_iam_role_policy_attachment" "lambda_s3" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

# Lambda function
resource "aws_lambda_function" "this" {
  function_name    = var.function_name
  role             = aws_iam_role.lambda_exec.arn
  handler          = var.handler
  runtime          = var.runtime
  filename         = var.filename
  source_code_hash = filebase64sha256(var.filename)
  timeout          = var.timeout
  memory_size      = var.memory_size

  environment {
    variables = {
      BUCKET_NAME = var.bucket_name
    }
  }

  tags = var.tags
}

# CloudWatch log group
resource "aws_cloudwatch_log_group" "lambda_logs" {
  name              = "/aws/lambda/${var.function_name}"
  retention_in_days = 14
  tags              = var.tags
}