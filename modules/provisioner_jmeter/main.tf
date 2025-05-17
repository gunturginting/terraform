resource "null_resource" "provisioner" {
    count = length(var.jmeter_slaves_ip) + 1

    depends_on = [ var.ec2_jumpserver_id ]

    connection {
      type = "ssh"
      bastion_user = "ubuntu"
      bastion_private_key = file("~/Downloads/devops-poc.pem")
      bastion_host =  var.ec2_jumpserver_public_ip
      user = "ubuntu"
      private_key = file("~/Downloads/devops-poc.pem")
      host = count.index == 0 ? var.jmeter_master_ip : var.jmeter_slaves_ip[count.index - 1]
    }

    provisioner "remote-exec" {
      inline = [ 
          "sudo apt update",
          "sudo apt install -y unzip git curl wget software-properties-common",
          "sudo apt install -y openjdk-21-jdk",
          "wget https://archive.apache.org/dist/jmeter/binaries/apache-jmeter-5.6.2.tgz",
          "sudo tar -xvzf apache-jmeter-5.6.2.tgz",
          "sudo mv apache-jmeter-5.6.2 /opt/jmeter",
          "echo 'export PATH=$PATH:/opt/jmeter/bin' >> ~/.bashrc",
          "source ~/.bashrc",
          "jmeter -v"
       ] 
    }
}
