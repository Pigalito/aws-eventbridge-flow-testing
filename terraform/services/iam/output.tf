output "lambda_role_arn" {
  value = aws_iam_role.lambda_role.arn
}

output "firehose_role_arn" {
  value = aws_iam_role.firehose_role.arn
}

output "eventbridge_firehose_role_arn" {
  value = aws_iam_role.eventbridge_firehose_role.arn
}