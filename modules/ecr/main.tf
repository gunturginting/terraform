resource "awscc_ecr_repository" "ecr_whatsapp_bill_backoffice" {
    repository_name = "ppob/whatsapp-bill-backoffice"
    image_tag_mutability = "MUTABLE"
    image_scanning_configuration = {
      scan_on_push = false
    }
}