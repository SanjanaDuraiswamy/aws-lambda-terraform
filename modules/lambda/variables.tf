variable "function_name" {
  description = "Name of the Lambda function"
}

variable "role_arn" {
  description = "ARN of the IAM execution role"
}

variable "filename" {
  description = "Path to the Lambda ZIP file"
}

variable "handler" {
  description = "Lambda handler in filename.function format"
}

variable "runtime" {
  description = "Lambda runtime identifier"
}

variable "timeout" {
  description = "Function timeout in seconds"
}

variable "memory_size" {
  description = "Function memory allocation in MB"
  type        = number
  default     = 256
}

variable "tags" {
  description = "Mandatory tags for all resources"
  type        = map(string)
}