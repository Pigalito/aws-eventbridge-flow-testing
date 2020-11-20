output "sqs_eventbridge_target_arn" {
  value = aws_sqs_queue.eventbridge_target.arn
}