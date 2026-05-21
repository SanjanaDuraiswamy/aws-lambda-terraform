# Step 1 - Create Permissions Boundary Policy
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
          "cloudwatch:*",
          "iam:*"
        ]
        Resource = "*"
      },
      {
        Sid    = "DenyEC2"
        Effect = "Deny"
        Action = [
          "ec2:RunInstances",
          "ec2:StartInstances",
          "ec2:CreateInstance",
          "ec2:TerminateInstances",
          "ec2:*"
        ]
        Resource = "*"
      }
    ]
  })
}

# Step 2 - Create github-oidc-role WITH boundary
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

# Step 3 - Attach permissions to github-oidc-role
resource "aws_iam_role_policy_attachment" "oidc_lambda" {
  role       = aws_iam_role.github_oidc_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSLambda_FullAccess"
}

resource "aws_iam_role_policy_attachment" "oidc_glue" {
  role       = aws_iam_role.github_oidc_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole"
}

resource "aws_iam_role_policy_attachment" "oidc_s3" {
  role       = aws_iam_role.github_oidc_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_role_policy_attachment" "oidc_cloudwatch" {
  role       = aws_iam_role.github_oidc_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchFullAccess"
}

resource "aws_iam_role_policy_attachment" "oidc_iam" {
  role       = aws_iam_role.github_oidc_role.name
  policy_arn = "arn:aws:iam::aws:policy/IAMFullAccess"
}