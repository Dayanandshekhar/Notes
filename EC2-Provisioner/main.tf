provider "aws" {
	region = "ap-southeast-1"
}

resource "aws_security_group" "my-sg" {
  vpc_id      = "vpc-0aeceaae7c28cf83f"

  ingress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "My-Sg"
  }
}

resource "aws_instance" "my-instance" {
	ami = "ami-051f0947e420652a9"
	instance_type = "t2.micro"
	key_name = "may2022"
	vpc_security_group_ids = [aws_security_group.my-sg.id]
	tags = {
    Name = "Terraform-Instance"
    } 

	connection {
		type = "ssh"
		user = "ec2-user"
		private_key = file("./may2022.pem")
		host = aws_instance.my-instance.public_ip
	}
	
	provisioner "file" {
		source = "./script.sh"
		destination = "/home/ec2-user/script.sh"
	}
	
	provisioner "remote-exec" {
		inline = [
			"chmod u+x /home/ec2-user/script.sh",
			"sh /home/ec2-user/script.sh"
		]
	}

}

output "public-ip" {
	value = aws_instance.my-instance.public_ip
}