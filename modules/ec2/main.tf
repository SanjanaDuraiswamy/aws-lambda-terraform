# EC2 role — this will be BLOCKED by boundary!
resource "aws_iam_role" "ec2_exec" {
  name = "${var.instance_name}-exec-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = { Service = "ec2.amazonaws.com" }
      Action    = "sts:AssumeRole"
    }]
  })

  tags = var.tags
}

# Attach EC2 policy — boundary will block this!
resource "aws_iam_role_policy_attachment" "ec2_full" {
  role       = aws_iam_role.ec2_exec.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}