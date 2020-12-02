resource "aws_cloudwatch_event_rule" "rule" {
  name           = var.name
  description    = var.description
  event_pattern  = var.event_pattern
  event_bus_name = var.event_bus_name
  schedule_expression = var.schedule_expression
}

resource "aws_cloudwatch_event_target" "target" {
  rule           = var.name
  arn            = var.target_arn
  event_bus_name = var.event_bus_name
  role_arn       = var.role_arn

  dynamic "input_transformer" {
    for_each = local.input_transformer

    content {
      input_paths = input_transformer.value.input_paths
      input_template = input_transformer.value.input_template
    }
  }
}

locals {
  input_transformer = var.input_transformer == null ? [] : [var.input_transformer]
}
