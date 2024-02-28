//로드밸런스
resource "aws_lb" "example" {
  name               = "aws05-alb"
  load_balancer_type = "application"
  subnets            = [data.terraform_remote_state.vpc.outputs.public-subnet-2a-id, data.terraform_remote_state.vpc.outputs.public-subnet-2c-id]
  security_groups    = [aws_security_group.target-sg.id]
}

// 로드밸런스 리스너
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.example.arn
  port              = var.target-port
  protocol          = "HTTP"
  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "404: page not found"
      status_code  = 404
    }
  }
}

//로드밸런스 리스너 룰
resource "aws_lb_listener_rule" "asg" {
  listener_arn = aws_lb_listener.http.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.asg.arn
  }

  condition {
    path_pattern {
      values = ["*"]
    }
  }
}

//대상그룹
resource "aws_lb_target_group" "asg" {
  name     = "aws05-target-group-example"
  port     = var.target-port
  protocol = "HTTP"
  vpc_id   = data.terraform_remote_state.vpc.outputs.vpc_id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 15
    timeout             = 3
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

# 시작 템플릿
resource "aws_launch_template" "example" {
  name                   = "aws05-template"
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

  target_group_arns = [aws_lb_target_group.asg.arn]
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