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
  ]
}
EOF
  name           = "standard-to-sqs"
  description    = "Passes events that need action to SQS"
  event_bus_name = "standard-bus"
  target_arn     = var.sqs_eventbridge_target_arn
}