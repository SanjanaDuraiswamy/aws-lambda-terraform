variable "job_name" {
  description = "Name of the Glue job"
  type        = string
}

variable "script_location" {
  description = "S3 path to the Glue script"
  type        = string
}

variable "bucket_name" {
  description = "S3 bucket for Glue to read/write"
  type        = string
}

variable "tags" {
  description = "Mandatory tags for all resources"
  type        = map(string)
}