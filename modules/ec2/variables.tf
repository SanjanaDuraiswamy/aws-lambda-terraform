variable "instance_name" {
  description = "Name of the EC2 instance"
  type        = string
}

variable "tags" {
  description = "Mandatory tags"
  type        = map(string)
}