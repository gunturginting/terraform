output "jumphost_public_ip" {
    description = "Public IP"
    value = aws_instance.jumpserver.public_ip
}

output "jumphost_private_ip" {
    description = "Private IP"
    value = aws_instance.jumpserver.private_ip
}

output "jumphost_id" {
    description = "Instance ID"
    value = aws_instance.jumpserver.id
}