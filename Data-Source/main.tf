provider "aws" {
	region = "ap-southeast-1"
}

data "aws_instance" "my-ec2-data" {
	instance_tags = {
		Name = "data"
	}
}

resource "null_resource" "run-provisioner" {
	connection {
		type = "ssh"
		user = "ec2-user"
		private_key = file("./may2022.pem")
		host = data.aws_instance.my-ec2-data.public_ip
	}
	
	provisioner "file" {
		source = "./script.sh"
		destination = "/home/ec2-user/script.sh"
	}
}

output "instance-id" {
	value = data.aws_instance.my-ec2-data.id
}

output "public-ip" {
	value = data.aws_instance.my-ec2-data.public_ip
}