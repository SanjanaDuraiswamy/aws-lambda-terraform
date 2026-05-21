resource "aws_iam_policy" "oidc_boundary" {
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
          "glue:*",
          "s3:*",
          "logs:*",
          "cloudwatch:*"
        ]
        Resource = "*"
      }
    ]
  })
}