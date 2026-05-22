resource "aws_iam_policy" "github_oidc_boundary" {

  name        = "github-oidc-boundary"
  description = "Permissions boundary - Lambda, Glue, S3, CloudWatch"

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Sid    = "AllowedServices"
        Effect = "Allow"
        Action = [
          "lambda:*",
          "s3:*",
          "glue:*",
          "logs:*",
          "cloudwatch:*",
          "iam:*"
        ]  
        Resource = "*"
      }
    ]
  })

  lifecycle {
    create_before_destroy = true
  }
}