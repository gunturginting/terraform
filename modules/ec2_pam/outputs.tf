output "pam_private_ip" {
    description = "Private IP"
    value = aws_instance.pam.private_ip
}

output "pam_id" {
    description = "Instance ID"
    value = aws_instance.pam.id
}