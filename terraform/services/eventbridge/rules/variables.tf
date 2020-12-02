variable "event_pattern" {
  default = ""
}
variable "name" {}
variable "description" {}
variable "event_bus_name" {}
variable "target_arn" {}
variable "schedule_expression" {
  default = ""
}
variable "role_arn" {
  default = null
}
variable "input_transformer" {
  default = null
}
