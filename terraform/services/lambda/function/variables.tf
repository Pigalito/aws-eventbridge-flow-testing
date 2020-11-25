// Required variables for all lambdas

variable "name" {}
variable "iam_role" {}
variable "deployment_bucket" {}

// Optional variables for all lambdas
variable "env_vars" {
  default = {}
}
variable "lambda_version" {
  default = "1.0.0"
}

// Variables that must be overridden for lambdas triggered by SQS
variable "include_sqs" {
  default = 0
}

variable "sqs_queue_arn" {
  default = ""
}