# Glue execution role
resource "aws_iam_role" "glue_exec" {
  name = "${var.job_name}-exec-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = { Service = "glue.amazonaws.com" }
      Action    = "sts:AssumeRole"
    }]
  })

  tags = var.tags
}

# Attach Glue service role policy
resource "aws_iam_role_policy_attachment" "glue_service" {
  role       = aws_iam_role.glue_exec.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole"
}

# Attach S3 full access policy
resource "aws_iam_role_policy_attachment" "glue_s3" {
  role       = aws_iam_role.glue_exec.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

# Glue job
resource "aws_glue_job" "this" {
  name     = var.job_name
  role_arn = aws_iam_role.glue_exec.arn

  command {
    name            = "glueetl"
    script_location = var.script_location
    python_version  = "3"
  }

  default_arguments = {
    "--job-language"        = "python"
    "--BUCKET_NAME"         = var.bucket_name
    "--enable-continuous-cloudwatch-log" = "true"
  }

  glue_version      = "4.0"
  number_of_workers = 2
  worker_type       = "G.1X"

  tags = var.tags
}

# CloudWatch log group for Glue
resource "aws_cloudwatch_log_group" "glue_logs" {
  name              = "/aws-glue/jobs/${var.job_name}"
  retention_in_days = 14
  tags              = var.tags
}