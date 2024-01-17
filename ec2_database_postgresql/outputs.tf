output "public_ip" {
  value = aws_instance.database.public_ip
}

output "ec2_id" {
  value = aws_instance.database.id
}
