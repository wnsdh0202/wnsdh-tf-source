# 시작 템플릿
resource "aws_launch_template" "example" {
  name                   = "aws05-example-template"
  image_id               = "ami-067dcaefc2fbfca82"
  instance_type          = "t2.micro"
  key_name               = "aws05-key"
  vpc_security_group_ids = [data.terraform_remote_state.Security_groups.outputs.aws-security-group-ssh-id, data.terraform_remote_state.Security_groups.outputs.aws-security-group-web-id]

  user_data = base64encode(data.template_file.web_output.rendered)

  lifecycle {
    create_before_destroy = true
  }
}

# 오토스케일링 그룹
resource "aws_autoscaling_group" "example" {
#   availability_zones = ["ap-northeast-2a", "ap-northeast-2c"]
  vpc_zone_identifier = [data.terraform_remote_state.vpc.outputs.private-subnet-2a-id, data.terraform_remote_state.vpc.outputs.private-subnet-2c-id]
  name = "aws05-asg-example"
  desired_capacity = 1
  min_size = 1
  max_size = 2

  target_group_arns = [data.terraform_remote_state.alb.outputs.target_group_arns]
  health_check_type = "ELB"


  launch_template {
    id = aws_launch_template.example.id
    version = "$Latest"
  }

  tag {
    key = "Name" 
    value = "aws05-asg-example"
    propagate_at_launch = true
  }
}


data "template_file" "web_output" {
  template = file("${path.module}/web.sh")
  vars = {
    web_port = "${var.web_port}"
  }
}