resource "aws_iam_policy" "github_oidc_boundary" {

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [

      {
        Sid    = "AllowLambda"
        Effect = "Allow"

        Action = [
          "lambda:*"
        ]

        Resource = "*"
      },

      {
        Sid    = "AllowS3"
        Effect = "Allow"

        Action = [
          "s3:*"
        ]

        Resource = "*"
      },

      {
        Sid    = "AllowGlue"
        Effect = "Allow"

        Action = [
          "glue:*"
        ]

        Resource = "*"
      },

      {
        Sid    = "AllowLogs"
        Effect = "Allow"

        Action = [
          "logs:*",
          "cloudwatch:*"
        ]

        Resource = "*"
      },

      {
        Sid    = "AllowIAMForRoles"
        Effect = "Allow"

        Action = [
          "iam:GetRole",
          "iam:CreateRole",
          "iam:DeleteRole",
          "iam:UpdateRole",
          "iam:AttachRolePolicy",
          "iam:DetachRolePolicy",
          "iam:PutRolePolicy",
          "iam:DeleteRolePolicy",
          "iam:PassRole",
          "iam:TagRole",
          "iam:UntagRole"
        ]

        Resource = "*"
      }
    ]
  })
}