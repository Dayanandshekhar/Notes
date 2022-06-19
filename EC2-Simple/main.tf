provider "aws" {
	region = "ap-southeast-1"
}

resource "aws_instance" "my-instance" {
	tags = {
			Name = "terraform-ec2"
	}
	ami = "ami-051f0947e420652a9"
	instance_type = "t2.micro"
	key_name = "may2022"
}







