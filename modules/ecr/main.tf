resource "awscc_ecr_repository" "ecr_solo-gateway" {
    repository_name = "solo/solo-gateway"
    image_tag_mutability = "MUTABLE"
    image_scanning_configuration = {
      scan_on_push = false
    }
}

resource "awscc_ecr_repository" "ecr_solo-prepaid" {
    repository_name = "solo/solo-prepaid"
    image_tag_mutability = "MUTABLE"
    image_scanning_configuration = {
      scan_on_push = false
    }
}

resource "awscc_ecr_repository" "ecr_solo-postpaid" {
    repository_name = "solo/solo-postpaid"
    image_tag_mutability = "MUTABLE"
    image_scanning_configuration = {
      scan_on_push = false
    }
}

resource "awscc_ecr_repository" "ecr_solo-nontaglis" {
    repository_name = "solo/solo-nontaglis"
    image_tag_mutability = "MUTABLE"
    image_scanning_configuration = {
      scan_on_push = false
    }
}

resource "awscc_ecr_repository" "ecr_solo-scheduler" {
    repository_name = "solo/solo-scheduler"
    image_tag_mutability = "MUTABLE"
    image_scanning_configuration = {
      scan_on_push = false
    }
}

resource "awscc_ecr_repository" "ecr_solo-klaten" {
    repository_name = "solo/solo-klaten"
    image_tag_mutability = "MUTABLE"
    image_scanning_configuration = {
      scan_on_push = false
    }
}