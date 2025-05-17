variable "ami_ubuntu_22_arm" {
    description = "AMI Name"
    type = string
    default = "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-arm64-server-*"
}

variable "ami_ubuntu_22_amd" {
    description = "AMI Name"
    type = string
    default = "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"
}

variable "canonical" {
    description = "Owners Canonical"
    type = string
    default = "099720109477"
}