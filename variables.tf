variable "aws_region" {
  description = "AWS region to deploy into"
  default     = "us-east-1"
}

variable "function_name" {
  description = "Name of the Lambda function"
}

variable "lambda_role_arn" {
  description = "ARN of the pre-existing IAM execution role for Lambda"
}

variable "handler" {
  description = "Lambda handler in filename.function_name format"
}

variable "runtime" {
  description = "Lambda runtime"
}

variable "timeout" {
  description = "Lambda timeout in seconds"
  default     = 30
}

variable "memory_size" {
  description = "Lambda memory in MB"
  default     = 256
}

variable "tags" {
  description = "Mandatory tags for all resources"
  type        = map(string)
}