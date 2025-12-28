variable "vpc_default" {
  description = "Default VPC"
  type = string
}

variable "subnets" {
  description = "List of subnets from default VPC"
  type = list(string)
}