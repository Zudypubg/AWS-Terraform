resource "aws_ecr_repository" "aws_ecr" {
    name                    = var.repository_name
    image_tag_mutability    = "MUTABLE"
    tags                    = var.tags
}