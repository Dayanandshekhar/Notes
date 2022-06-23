terraform {
	backend "s3" {
		bucket = "s3bucket-for-remotestate-123892173"
		key = "terraform/remotestate/terraform.tfstate"
		region = "ap-southeast-1"
		
		dynamodb_table = "dynamodb-for-remotestate"
		encrypt = true
	}
}

provider "aws" {
	region = "ap-southeast-1"
}

resource "aws_instance" "my-instance" {
	count = 4
	ami = "ami-051f0947e420652a9"
	instance_type = "t2.micro"
	key_name = "may2022"
}

