output "repository_url" {
    value = aws_ecr_repository.ecr_repo.repository_url
}

output "repository_arn" {
    value = aws_ecr_repository.ecr_repo.arn
}