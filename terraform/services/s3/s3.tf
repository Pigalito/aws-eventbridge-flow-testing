resource "aws_s3_bucket" "events_bucket" {
  bucket = var.events_bucket_name
  acl    = "private"
}