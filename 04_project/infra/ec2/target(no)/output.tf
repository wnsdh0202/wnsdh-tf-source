output "public_ip" {
  value       = aws_instance.target.public_ip
  description = "The Public IP of the Instance"
}