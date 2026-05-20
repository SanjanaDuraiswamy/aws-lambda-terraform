resource "aws_iam_policy" "oidc_boundary" {
  name        = "github-oidc-boundary"
  description = "Permissions boundary - restricts to Lambda permissions only"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowLambdaPermissionsOnly"
        Effect = "Allow"
        Action = [
          "lambda:*",
          "logs:*",
          "cloudwatch:*"
        ]
        Resource = "*"
      }
    ]
  })
}


resource "aws_iam_role_policy_attachment" "oidc_boundary" {
  role       = "github-oidc-role"
  policy_arn = aws_iam_policy.oidc_boundary.arn
}