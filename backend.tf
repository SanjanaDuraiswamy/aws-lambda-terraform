# Remote backend will be configured once S3 bucket is created
# terraform {
#   backend "s3" {
#     bucket = "your-terraform-state-bucket"
#     key    = "lambda/terraform.tfstate"
#     region = "us-east-1"
#   }
# }