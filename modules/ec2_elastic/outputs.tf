output "elastic_private_ip" {
    description = "Public IP"
    value = aws_instance.elastic.private_ip
}

output "kibana_private_ip" {
    description = "Private IP"
    value = aws_instance.kibana.private_ip
}

output "elastic_id" {
    description = "Instance ID"
    value = aws_instance.elastic.id
}

output "kibana_id" {
    description = "Instance ID"
    value = aws_instance.kibana.id
}