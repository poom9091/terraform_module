resource "aws_ecr_repository" "application_repo" {
  name                 = "${var.environment}-${var.project_name}-${var.service}"
  image_tag_mutability = "MUTABLE"

  force_delete = var.force_delete
  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_lifecycle_policy" "policy" {
  repository = aws_ecr_repository.application_repo.name

  policy = <<EOF
  {
  "rules": [
    {
      "rulePriority": 1,
      "description": "Keep last 5 images",
      "selection": {
        "tagStatus": "untagged",
        "countType": "imageCountMoreThan",
        "countNumber": 5
      },
      "action": { "type": "expire" }
    }
  ]
  }
  EOF 
}
