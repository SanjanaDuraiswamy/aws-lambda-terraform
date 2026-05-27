# EC2 instance — this should be BLOCKED by the permissions boundary
# because ec2:RunInstances is not in the AllowedServices list
resource "aws_instance" "test" {
  ami           = var.ami_id
  instance_type = var.instance_type

  tags = merge(var.tags, {
    Name = var.instance_name
  })
}
