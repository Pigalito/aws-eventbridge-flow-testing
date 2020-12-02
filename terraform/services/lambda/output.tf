output "sqs_target_lambda_arn" {
  value = module.sqs_target_lambda.arn
}

output "trigger_eventbridge_lambda_arn" {
  value = module.trigger_eventbridge_lambda.arn
}
