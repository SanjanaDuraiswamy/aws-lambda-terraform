aws_region      = "us-east-1"
function_name   = "sanjana-lambda"

handler         = "lambda-fun.handler"
runtime         = "python3.12"
timeout         = 30
memory_size     = 256

tags = {
  Name           = "sanjana-lambda"
  Owner          = "Sanjana Duraiswamy"
  ContactEmail   = "swamysanj@gmail.com"
  Application    = "aws-lambda-terraform"
  Project        = "aws-task"
  ProjectEndDate = "2026-12-31" 
}