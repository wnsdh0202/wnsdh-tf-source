resource "aws_instance" "jenkins" {
  ami = "ami-09eb4311cbaecf89d"
  instance_type = "t2.micro"
  key_name = "aws05-key"

  associate_public_ip_address = true # 퍼블릭 아이피 활성화

  subnet_id = data.terraform_remote_state.vpc.outputs.public-subnet-2a-id

  vpc_security_group_ids = [data.terraform_remote_state.Security_groups.outputs.aws-security-group-ssh-id]
  # security_groups = data.terraform_remote_state.Security_groups.outputs.aws-security-group-ssh-id

  

  tags = {
    Name = "aws05-jenkins"
  }
}