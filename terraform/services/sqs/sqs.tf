resource "aws_sqs_queue" "eventbridge_target" {
  name = "eventbridge-target"
}