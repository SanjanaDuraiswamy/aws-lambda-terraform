# Permissions Boundary Policy
resource "aws_iam_policy" "oidc_boundary" {
  name        = "github-oidc-boundary"
  description = "Permissions boundary - Lambda, Glue, S3, CloudWatch only"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowedServicesOnly"
        Effect = "Allow"
        Action = [
          "lambda:*",
          "s3:*",
          "glue:*",
          "cloudwatch:*",
          "logs:*",
          "iam:CreateRole",
          "iam:DeleteRole",
          "iam:AttachRolePolicy",
          "iam:DetachRolePolicy",
          "iam:PassRole",
          "iam:Get*",
          "iam:List*",
          "iam:TagRole",
          "iam:UntagRole",
          "iam:PutRolePermissionsBoundary"
        ]
        Resource = "*"
      }
    ]
  })
}

# Attach boundary to github-oidc-role
resource "null_resource" "attach_boundary" {
  provisioner "local-exec" {
    command = "aws iam put-role-permissions-boundary --role-name github-oidc-role --permissions-boundary ${aws_iam_policy.oidc_boundary.arn}"
  }

  depends_on = [aws_iam_policy.oidc_boundary]
}