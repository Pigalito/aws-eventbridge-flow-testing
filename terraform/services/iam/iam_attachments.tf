resource "aws_iam_role_policy_attachment" "cloudwatch_lambda_policy_role_attachment" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.cloudwatch_lambda_policy.arn
}

resource "aws_iam_role_policy_attachment" "eventbridge_lambda_policy_role_attachment" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.eventbridge_lambda_policy.arn
}

resource "aws_iam_role_policy_attachment" "sqs_lambda_policy_role_attachment" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.sqs_lambda_policy.arn
}

resource "aws_iam_role_policy_attachment" "eventbridge_firehose_policy_role_attachment" {
  role       = aws_iam_role.eventbridge_firehose_role.name
  policy_arn = aws_iam_policy.put_record_firehose_policy.arn
}
