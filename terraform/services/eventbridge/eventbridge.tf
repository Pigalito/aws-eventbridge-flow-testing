module "standard_bus" {
  source = "./bus"
  name   = "standard-bus"
}

module "standard_bus_sqs_trigger" {
  source         = "./rules"
  event_pattern  = <<EOF
{
  "detail-type": [
    "Event triggered from dedicated lambda"
  ],
  "detail": {
    "booleanVal": [
      true
    ]
  }
}
EOF
  name           = "standard-to-sqs"
  description    = "Passes events that need action to SQS"
  event_bus_name = "standard-bus"
  target_arn     = var.sqs_eventbridge_target_arn
}

module "standard_bus_firehose_trigger" {
  source         = "./rules"
  event_pattern  = <<EOF
{
  "detail-type": [
    "Event triggered from dedicated lambda"
  ]
}
EOF
  name           = "standard-to-kinesis"
  description    = "Passes all events to S3 via Kinesis firehose"
  event_bus_name = "standard-bus"
  target_arn     = var.eventbridge_s3_firehose_stream_arn
  role_arn       = var.eventbridge_firehose_role_arn
}