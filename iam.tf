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
      },
      {
        Sid    = "DenyEverythingElse"
        Effect = "Deny"
        NotAction = [
          "lambda:*",
          "s3:*",
          "glue:*",
          "cloudwatch:*",
          "logs:*",
          "iam:*"
        ]
        Resource = "*"
      }
    ]
  })
}

# github-oidc-role with boundary
resource "aws_iam_role" "github_oidc_role" {
  name                 = "github-oidc-role"
  permissions_boundary = aws_iam_policy.oidc_boundary.arn

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Federated = "arn:aws:iam::137982683320:oidc-provider/token.actions.githubusercontent.com"
      }
      Action = "sts:AssumeRoleWithWebIdentity"
      Condition = {
        StringEquals = {
          "token.actions.githubusercontent.com:aud" = "sts.amazonaws.com"
        }
        StringLike = {
          "token.actions.githubusercontent.com:sub" = "repo:SanjanaDuraiswamy/aws-lambda-terraform:*"
        }
      }
    }]
  })

  tags = var.tags
}

# Minimum IAM permissions only!
resource "aws_iam_role_policy" "oidc_iam_policy" {
  name = "github-oidc-iam-policy"
  role = aws_iam_role.github_oidc_role.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "MinimumIAMPermissions"
        Effect = "Allow"
        Action = [
          "iam:Get*",
          "iam:List*",
          "iam:CreateRole",
          "iam:DeleteRole",
          "iam:UpdateRole",
          "iam:TagRole",
          "iam:UntagRole",
          "iam:AttachRolePolicy",
          "iam:DetachRolePolicy",
          "iam:PutRolePolicy",
          "iam:DeleteRolePolicy",
          "iam:PassRole",
          "iam:CreateInstanceProfile",
          "iam:DeleteInstanceProfile",
          "iam:AddRoleToInstanceProfile",
          "iam:RemoveRoleFromInstanceProfile",
          "iam:PutRolePermissionsBoundary",
          "iam:DeleteRolePermissionsBoundary",
          "iam:CreatePolicy",
          "iam:CreatePolicyVersion",
          "iam:DeletePolicy",
          "iam:DeletePolicyVersion"
        ]
        Resource = "*"
      }
    ]
  })
}

# Lambda permissions
resource "aws_iam_role_policy_attachment" "oidc_lambda" {
  role       = aws_iam_role.github_oidc_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSLambda_FullAccess"
}

# Glue permissions
resource "aws_iam_role_policy_attachment" "oidc_glue" {
  role       = aws_iam_role.github_oidc_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole"
}

# S3 permissions
resource "aws_iam_role_policy_attachment" "oidc_s3" {
  role       = aws_iam_role.github_oidc_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

# CloudWatch permissions
resource "aws_iam_role_policy_attachment" "oidc_cloudwatch" {
  role       = aws_iam_role.github_oidc_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchFullAccess"
}