resource "aws_iam_role" "github_oidc_role" {

  name = "github-oidc-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Federated = aws_iam_openid_connect_provider.github.arn
        }

        Action = "sts:AssumeRoleWithWebIdentity"

        Condition = {
          StringLike = {
            "token.actions.githubusercontent.com:sub" =
            "repo:${var.github_repo}:*"
          }
        }
      }
    ]
  })

  permissions_boundary = aws_iam_policy.github_oidc_boundary.arn
}

resource "aws_iam_role_policy_attachment" "github_admin_attach" {

  role = aws_iam_role.github_oidc_role.name

  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}