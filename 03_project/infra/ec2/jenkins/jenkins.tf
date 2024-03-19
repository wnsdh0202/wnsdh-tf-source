resource "aws_instance" "jenkins" {
  ami = "ami-0a19a5ced409f1c2f"
  instance_type = "t3.large"
  key_name = "aws05-key"
  private_ip = "10.5.64.100"
  # associate_public_ip_address = true # 퍼블릭 아이피 활성화
  vpc_security_group_ids = [data.terraform_remote_state.Security_groups.outputs.aws-security-group-ssh-id,
                            data.terraform_remote_state.Security_groups.outputs.aws-security-group-web-id]
  subnet_id = data.terraform_remote_state.vpc.outputs.private-subnet-2a-id

  user_data = templatefile("templates/userdata.sh", {})
  # security_groups = data.terraform_remote_state.Security_groups.outputs.aws-security-group-ssh-id

  tags = {
    Name = "aws05-jenkins"
  }
}