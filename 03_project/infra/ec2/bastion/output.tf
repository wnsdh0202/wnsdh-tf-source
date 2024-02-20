output "public_ip" {
  value       = aws_instance.bastion.public_ip
  description = "The Public IP of the Instance"
}