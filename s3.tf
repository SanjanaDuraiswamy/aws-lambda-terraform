
resource "aws_s3_bucket" "data_bucket" {
  bucket = "sanjana-data-bucket-137982683320"
  tags   = var.tags
}


resource "aws_s3_object" "input_folder" {
  bucket  = aws_s3_bucket.data_bucket.id
  key     = "input/"
  content = ""
}


resource "aws_s3_object" "input_file" {
  bucket  = aws_s3_bucket.data_bucket.id
  key     = "input/data.csv"
  content = "name,age\nSanjana,25\nBrillio,10\nAWS,20"
}