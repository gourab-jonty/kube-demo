variable "vpc_id" {}

variable "ingress_rules" {
  type = list(object({
    port = number
  }))
}
variable "vpc_cidr" {
  type = list(string)
}
variable "name" {}