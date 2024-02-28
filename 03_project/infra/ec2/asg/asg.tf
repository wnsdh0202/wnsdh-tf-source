# 시작 템플릿
resource "aws_launch_template" "example" {
  name                   = "aws05-example-template"
  image_id               = "ami-0749ee237f33e64f4"
  instance_type          = "t2.micro"
  key_name               = "aws05-key"
  vpc_security_group_ids = [aws_security_group.target-sg.id]
  iam_instance_profile {
    name = "aws05-codedeploy-ec2-role"
  }

  lifecycle {
    create_before_destroy = true
  }
}

# 오토스케일링 그룹
resource "aws_autoscaling_group" "example" {
#   availability_zones = ["ap-northeast-2a", "ap-northeast-2c"]
  vpc_zone_identifier = [data.terraform_remote_state.vpc.outputs.private-subnet-2a-id, 
                        data.terraform_remote_state.vpc.outputs.private-subnet-2c-id]
  name = "aws05-asg"
  desired_capacity = 1
  min_size = 1
  max_size = 3

  target_group_arns = [data.terraform_remote_state.alb.outputs.target_group_arns]
  health_check_type = "ELB"


  launch_template {
    id = aws_launch_template.example.id
    version = "$Latest"
  }

  tag {
    key = "Name" 
    value = "aws05-asg"
    propagate_at_launch = true
  }
}

resource "aws_security_group" "target-sg" {
  name = "aws05-target-sg"
  vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id
  ingress {
    from_port   = var.target-port
    to_port     = var.target-port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "aws05-target-sg"
  }
}