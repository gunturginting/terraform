output "ecr_name" {
    description = "ECR Name"
    value = awscc_ecr_repository.ecr_whatsapp_bill_backoffice.repository_name
}