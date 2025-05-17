output "jmeter_master_ip" {
    value = aws_instance.jmeter_master.private_ip
}

output "jmeter_slaves_ip" {
  value = aws_instance.jmeter_slave[*].private_ip
}