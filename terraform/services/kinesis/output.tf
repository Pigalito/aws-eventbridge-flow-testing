output "eventbridge_s3_firehose_stream_arn" {
  value = aws_kinesis_firehose_delivery_stream.eventbridge_s3_firehose_stream.arn
}