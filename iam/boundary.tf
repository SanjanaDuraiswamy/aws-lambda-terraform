resource "aws_iam_policy" "github_oidc_boundary" {

  name        = "github-oidc-boundary"
  description = "Permissions boundary - allows only Lambda, S3, Glue, CloudWatch, IAM"

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
}