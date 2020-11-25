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
  source                     = "./services/eventbridge"
  sqs_eventbridge_target_arn = module.sqs.sqs_eventbridge_target_arn
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

