output "ami_id" {
  value = data.aws_ami.ubuntu.id
}

output "ami_id_amd" {
  value = data.aws_ami.ubuntu-amd.id
}