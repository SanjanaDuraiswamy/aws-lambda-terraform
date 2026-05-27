terraform {
  backend "s3" {
    bucket = "terraform-state-137982683320"
    key    = "aws-lambda-terraform/lambda/terraform.tfstate"
    region = "us-east-1"
  }
}   