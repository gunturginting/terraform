variable "ec2_jumpserver_id" {
    description = "EC2 Jumphost ID"
    type = string
}

variable "ec2_jumpserver_public_ip" {
    description = "EC2 Jumphost Public IP"
    type = string
}

variable "jmeter_master_ip" {
    type = string
}

variable "jmeter_slaves_ip" {
    type = list(string)
}