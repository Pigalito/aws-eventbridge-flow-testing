terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.15"
    }
  }
}

terraform {
  backend "remote" {
    organization = "HackettIncorporated"

    workspaces {
      name = "HackettIncorporatedAWS"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = "us-east-2"
}

module "iam" {
  source = "./services/iam"
}

module "eventbridge" {
  source                             = "./services/eventbridge"
  sqs_eventbridge_target_arn         = module.sqs.sqs_eventbridge_target_arn
  trigger_eventbridge_lambda_arn     = module.lambda.trigger_eventbridge_lambda_arn
  eventbridge_firehose_role_arn      = module.iam.eventbridge_firehose_role_arn
  eventbridge_s3_firehose_stream_arn = module.kinesis.eventbridge_s3_firehose_stream_arn
}

module "lambda" {
  source                       = "./services/lambda"
  deployment_bucket            = var.deployment_bucket
  sqs_target_iam_role          = module.iam.lambda_role_arn
  trigger_eventbridge_iam_role = module.iam.lambda_role_arn
  sqs_eventbridge_target_arn   = module.sqs.sqs_eventbridge_target_arn
}

module "sqs" {
  source = "./services/sqs"
}

module "s3" {
  source             = "./services/s3"
  events_bucket_name = var.events_bucket_name
}

module "kinesis" {
  source            = "./services/kinesis"
  firehose_role_arn = module.iam.firehose_role_arn
  events_bucket_arn = module.s3.events_bucket_arn
}
