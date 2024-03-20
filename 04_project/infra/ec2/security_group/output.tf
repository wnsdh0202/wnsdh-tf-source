output "aws-security-group-ssh-id" {
  value       = aws_security_group.ssh.id
  description = "The Security_group's id for SSH"
}

output "aws-security-group-http-id" {
  value       = aws_security_group.http.id
  description = "The Security_group's id for WEB"
}

output "aws-security-group-https-id" {
  value       = aws_security_group.https.id
  description = "The Security_group's id for https"
}

output "aws-security-group-target_http_id" {
  value       = aws_security_group.target_http.id
  description = "The Security_group's id for WEB"
}