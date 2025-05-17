output "mongos_server_private_ips" {
  description = "Private IP addresses of the MongoS Servers"
  value       = aws_instance.mongos_server[*].private_ip
}

output "mongos_config_server_private_ips" {
  description = "Private IP addresses of the MongoS Config Servers"
  value       = aws_instance.mongos_config_server[*].private_ip
}

output "mongos_shard_1_private_ips" {
  description = "Private IP addresses of the MongoS Shard 1"
  value       = aws_instance.mongos_shard_1[*].private_ip
}

output "mongos_shard_2_private_ips" {
  description = "Private IP addresses of the MongoS Shard 2"
  value       = aws_instance.mongos_shard_2[*].private_ip
}