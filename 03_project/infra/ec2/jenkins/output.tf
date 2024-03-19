output "private_ip" {
  value       = aws_instance.jenkins.private_ip
  description = "The private IP of the Instance"
}

output "jenkins_id" {
  description = "The ID of the Instance"
  value = aws_instance.jenkins.id
}