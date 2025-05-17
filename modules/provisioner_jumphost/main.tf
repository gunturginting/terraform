resource "null_resource" "provisioner" {
    depends_on = [ var.ec2_jumpserver_id ]

    connection {
      type = "ssh"
      user = "ubuntu"
      private_key = file("~/Downloads/devops-poc.pem")
      host = var.ec2_jumpserver_public_ip
    }

    provisioner "remote-exec" {
      inline = [ 
          "sudo apt update",
          "sudo apt install -y unzip git curl wget software-properties-common",
          "sudo apt-add-repository -y ppa:ansible/ansible",
          "sudo apt update",
          "sudo apt install -y ansible",
          "curl https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip -o awscliv2.zip",
          "unzip awscliv2.zip",
          "sudo ./aws/install",
          "aws --version"
       ] 
    }
}
