output "ecr_name" {
    description = "ECR Name"
    value = awscc_ecr_repository.ecr_api_gateway.repository_name
}