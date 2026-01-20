data "aws_vpc" "vpc_default" {
  default = true
}

data "aws_subnets" "all_default_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc_default.id]
  }
}

data "aws_s3_bucket" "baitersburger-products-s3-bucket" {
  bucket = "baitersburger-products-infrastructure"
}