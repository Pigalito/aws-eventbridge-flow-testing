variable "name" {}
variable "description" {}
variable "target_arn" {}

// default is used anyway if not defined in resource but variable must have default value so may as well make it default
variable "event_bus_name" {
  default = "default"
}
variable "event_pattern" {
  default = ""
}
variable "schedule_expression" {
  default = ""
}
variable "role_arn" {
  default = null
}
variable "input_transformer" {
  default = null
}
