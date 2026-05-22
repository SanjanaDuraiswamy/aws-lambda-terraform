aws_region    = "us-east-1"
function_name = "sanjana-lambda"
glue_job_name = "sanjana-glue-job"
handler       = "lambda-fun.handler"
runtime       = "python3.12"
timeout       = 30
memory_size   = 256
ec2_instance_name = "sanjana-ec2"

tags = {
  Name           = "sanjana-project"
  Owner          = "Sanjana Duraiswamy"
  ContactEmail   = "swamysanj@gmail.com"
  Application    = "aws-lambda-terraform"
  Project        = "aws-task"
  ProjectEndDate = "2026-12-31"
}