# EC2 instance — this will be BLOCKED by boundary because ec2:RunInstances
# is NOT in the AllowedServices list of github-oidc-boundary.
resource "aws_instance" "test" {
  ami           = var.ami_id
  instance_type = var.instance_type

  tags = merge(var.tags, {
    Name = var.instance_name
  })
}