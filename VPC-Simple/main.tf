provider "aws" {
	region = "ap-southeast-1"
}

resource "aws_vpc" "my-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "Terraform-VPC"
  }
}

resource "aws_subnet" "my-public-subnet" {
  vpc_id     = aws_vpc.my-vpc.id
  cidr_block = "10.0.1.0/24"
  
  tags = {
    Name = "Terraform-Pubilc-Subnet"
  }
  
  map_public_ip_on_launch = "true"
  
}

resource "aws_internet_gateway" "my-igw" {
  vpc_id = aws_vpc.my-vpc.id

  tags = {
    Name = "Terraform-IGW"
  }
}

resource "aws_route_table" "my-rt" {
  vpc_id = aws_vpc.my-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my-igw.id
  }

  tags = {
    Name = "Terraform-Route-Table"
  }
}

resource "aws_route_table_association" "my-rta" {
  subnet_id      = aws_subnet.my-public-subnet.id
  route_table_id = aws_route_table.my-rt.id
}

resource "aws_security_group" "my-sg" {
  vpc_id      = aws_vpc.my-vpc.id

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
	count = 4
	ami = "ami-051f0947e420652a9"
	instance_type = "t2.micro"
	key_name = "may2022"
	subnet_id = aws_subnet.my-public-subnet.id
	vpc_security_group_ids = [aws_security_group.my-sg.id] 
	  tags = {
    Name = "Terraform-Instance ${count.index}"
  }
}

output "instance-id" {
	value = aws_instance.my-instance.0.id
}

output "public-ip" {
	value = aws_instance.my-instance.0.public_ip
}

output "vpc-id" {
	value = aws_vpc.my-vpc.id
}


