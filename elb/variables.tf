variable "infra_s3_bucket" {
  description = "Name of the S3 bucket"
  type = string
}

variable "vpc_default" {
  description = "Default VPC"
  type = string
}

variable "subnets" {
  description = "List of subnets from default VPC"
  type = list(string)
}