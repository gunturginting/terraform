resource "awscc_ecr_repository" "ecr_whatsapp_bill_backoffice" {
    repository_name = "ppob/whatsapp-bill-backoffice"
    image_tag_mutability = "MUTABLE"
    image_scanning_configuration = {
      scan_on_push = false
    }
}

resource "awscc_ecr_repository" "ecr_whatsapp_bill_payment_scheduler" {
    repository_name = "ppob/whatsapp-bill-payment-scheduler"
    image_tag_mutability = "MUTABLE"
    image_scanning_configuration = {
      scan_on_push = false
    }
}