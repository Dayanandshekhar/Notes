output "instance-id" {
	value = aws_instance.my-instance.id
}

output "public-ip" {
	value = aws_instance.my-instance.public_ip
}
