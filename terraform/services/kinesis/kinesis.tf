resource "aws_kinesis_firehose_delivery_stream" "eventbridge_s3_firehose_stream" {
  name        = "eventbridge-s3-firehose-stream"
  destination = "extended_s3"

  extended_s3_configuration {
    role_arn   = var.firehose_role_arn
    bucket_arn = var.events_bucket_arn
    buffer_size = 1
    buffer_interval = 60
  }
}