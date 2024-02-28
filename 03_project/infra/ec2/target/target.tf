resource "aws_instance" "target" {
  ami = "ami-09eb4311cbaecf89d"
  instance_type = "t2.micro"
  key_name = "aws05-key"

  associate_public_ip_address = true # 퍼블릭 아이피 활성화

  subnet_id = data.terraform_remote_state.vpc.outputs.public-subnet-2a-id

  # user_data = "${base64encode(data.template_file.user_data.rendered)}"

  vpc_security_group_ids = [data.terraform_remote_state.Security_groups.outputs.aws-security-group-ssh-id,
                            data.terraform_remote_state.Security_groups.outputs.aws-security-group-web-id,
                            data.terraform_remote_state.Security_groups.outputs.aws-security-group-https-id]

  tags = {
    Name = "aws05-target"
  }
}

# data "template_file" "user_data" {
#   template = file("${path.module}/template/userdata.sh")
# }
