module "sqs_target_lambda" {
  source            = "./function"
  name              = "sqs-target"
  lambda_version    = "1.0.2"
  iam_role          = var.sqs_target_iam_role
  deployment_bucket = var.deployment_bucket
  include_sqs       = 1
  sqs_queue_arn     = var.sqs_eventbridge_target_arn
}

module "trigger_eventbridge_lambda" {
  source            = "./function"
  name              = "trigger-eventbridge"
  lambda_version    = "1.0.2"
  iam_role          = var.trigger_eventbridge_iam_role
  deployment_bucket = var.deployment_bucket
  env_vars = {
    event_bus_name = "standard-bus"
  }
}