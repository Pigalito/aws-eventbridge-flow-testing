resource "aws_iam_role" "lambda_role" {
  name               = "lambda_iam_role"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role.json
}

resource "aws_iam_role" "firehose_role" {
  name               = "firehose_iam_role"
  assume_role_policy = data.aws_iam_policy_document.firehose_assume_role.json
}

resource "aws_iam_role" "eventbridge_firehose_role" {
  name               = "eventbridge_firehose_iam_role"
  assume_role_policy = data.aws_iam_policy_document.eventbridge_assume_role.json
}