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
    organization = ""

    workspaces {
      name = ""
    }
  }
}

provider "aws" {
  profile = "default"
  region  = "us-east-2"
}

module "eventbridge" {
  source                     = "./services/eventbridge"
  sqs_eventbridge_target_arn = module.sqs.sqs_eventbridge_target_arn
}

module "sqs" {
  source = "./services/sqs"
}