module "standard_bus" {
  source = "./bus"
  name   = "standard-bus"
}

module "standard_bus_trigger_eventbridge_trigger" {
  source         = "./rules"
  schedule_expression = "cron(0 0 * * ? *)"
  name           = "standard-to-lambda-trigger-eventbridge"
  description    = "Triggers the lambda for getting events at midnight everyday"
  target_arn     = var.trigger_eventbridge_lambda_arn
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
  input_transformer = {
    input_paths    = {
      booleanVal = "$.detail.boolean"
    }
    input_template = <<EOF
{
  "boolean_value": <booleanVal>
}
EOF
  }
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
  input_transformer = {
    input_paths    = {
      detail = "$.detail"
    }
    input_template = <<EOF
{
  "detail": <detail>
}
EOF
  }

}
