output "rds_cluster_endpoint" {
  description = "Endpoint untuk Aurora RDS cluster"
  value       = aws_rds_cluster.aurora_postgres.endpoint
}

output "security_group_id" {
  description = "ID dari Security Group untuk RDS"
  value       = aws_security_group.rds_sg.id
}
