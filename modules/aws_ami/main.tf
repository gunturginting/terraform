data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = [var.ami_ubuntu_22_arm]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = [var.canonical]
}

data "aws_ami" "ubuntu-amd" {
  most_recent = true

  filter {
    name   = "name"
    values = [var.ami_ubuntu_22_amd]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = [var.canonical]
}