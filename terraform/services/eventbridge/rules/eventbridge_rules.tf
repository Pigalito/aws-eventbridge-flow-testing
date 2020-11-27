resource "aws_cloudwatch_event_rule" "rule" {
  name           = var.name
  description    = var.description
  event_pattern  = var.event_pattern
  event_bus_name = var.event_bus_name
}

resource "aws_cloudwatch_event_target" "target" {
  rule           = var.name
  arn            = var.target_arn
  event_bus_name = var.event_bus_name
  role_arn = var.role_arn
}