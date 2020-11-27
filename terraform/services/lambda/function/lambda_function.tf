resource "aws_lambda_function" "lambda" {
  s3_bucket     = var.deployment_bucket
  s3_key        = "lambdas/${var.name}-${var.lambda_version}.zip"
  function_name = var.name
  role          = var.iam_role
  handler       = "index.handler"
  runtime       = "nodejs12.x"

  dynamic "environment" {
    for_each = local.environment_variables
    content {
      variables = environment.value
    }
  }
}

locals {
  environment_variables = var.env_vars == null ? [] : [var.env_vars]
}

resource "aws_cloudwatch_log_group" "lambda_log_group" {
  name              = "/aws/lambda/${var.name}"
  retention_in_days = 14
}

resource "aws_lambda_event_source_mapping" "sqs" {
  count            = var.include_sqs
  event_source_arn = var.sqs_queue_arn
  function_name    = aws_lambda_function.lambda.arn
  batch_size       = 1
}