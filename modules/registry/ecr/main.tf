resource "random_id" "suffix" {
  byte_length = 4
}

resource "aws_ecr_repository" "ecr" {
  name                 = join("", [ var.registry_name, random_id.suffix.hex ])
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}