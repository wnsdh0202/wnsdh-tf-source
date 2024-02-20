output "aws-security-group-ssh-id" {
  value       = aws_security_group.ssh.id
  description = "The Security_group's id for SSH"
}

output "aws-security-group-web-id" {
  value       = aws_security_group.web.id
  description = "The Security_group's id for WEB"
}
