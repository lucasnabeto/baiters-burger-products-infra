resource "aws_ecr_repository" "repository" {
  name = "baitersburger-products-repository"
}

resource "aws_ecs_cluster" "cluster" {
  name = "baitersburger-products-cluster"
}