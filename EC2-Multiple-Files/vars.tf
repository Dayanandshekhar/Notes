variable "ami" {
	description = "This is the ami of Redhat machine"
	default = "ami-051f0947e420652a9"
}

variable "instance-type" {
	description = "The instance type of redhat machine"
	default = "t2.micro"
}

variable "instance-name" {
	default = "terraform-ec2"
}