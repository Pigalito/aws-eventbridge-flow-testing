variable "event_pattern" {}
variable "name" {}
variable "description" {}
variable "event_bus_name" {}
variable "target_arn" {}
variable "role_arn" {
  default = null
}