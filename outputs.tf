# Define Output Values

# Attribute Reference
output "Bastion-1_publicip" {
  description = "EC2 Instance Public IP"
  value       = aws_instance.cvengine-Bastion-1.public_ip
}



output "web-1_privateip" {
  description = "EC2 Instance Private IP"
  value       = aws_instance.ec2-web-1.private_ip
}

