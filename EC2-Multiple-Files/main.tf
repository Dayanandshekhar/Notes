resource "aws_instance" "my-instance" {
	tags = {
			Name = var.instance-name
	}
	ami = var.ami
	instance_type = var.instance-type
	key_name = "may2022"
}






