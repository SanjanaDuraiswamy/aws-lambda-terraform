variable "account_id" {
  description = "AWS account ID for constructing ARNs"
  type        = string
}

variable "function_name" {
  description = "Name of the Lambda function"
  type        = string
}

variable "filename" {
  description = "Path to the Lambda ZIP file"
  type        = string
}

variable "handler" {
  description = "Lambda handler in filename.function format"
  type        = string
}

variable "runtime" {
  description = "Lambda runtime identifier"
  type        = string
}

variable "timeout" {
  description = "Function timeout in seconds"
  type        = number
}

variable "memory_size" {
  description = "Function memory allocation in MB"
  type        = number
  default     = 256
}

variable "bucket_name" {
  description = "S3 bucket name for Lambda to read/write"
  type        = string
}

variable "tags" {
  description = "Mandatory tags for all resources"
  type        = map(string)
}