resource "awscc_ecr_repository" "ecr_api_gateway" {
    repository_name = "pegadaian/api-gateway"
    image_tag_mutability = "MUTABLE"
    image_scanning_configuration = {
      scan_on_push = false
    }
}

resource "awscc_ecr_repository" "ecr_profile_services" {
    repository_name = "pegadaian/profile-services"
    image_tag_mutability = "MUTABLE"
    image_scanning_configuration = {
      scan_on_push = false
    }
}