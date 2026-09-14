
output "instance_id" {
  description = "ID of the EC2 instance."
  value       = aws_instance.app_server.id
}

output "instance_hostname" {
  description = "Private DNS name of the EC2 instance."
  value       = aws_instance.app_server.private_dns
}
