data "terraform_remote_state" "vpc" {
    backend = "s3"
    config = {
        bucket = "aws05-terraform-state"
        key = "infra/vpc/terraform.tfstate"
        region = "ap-northeast-2"
    }
}

data "terraform_remote_state" "Security_groups" {
    backend = "s3"
    config = {
        bucket = "aws05-terraform-state"
        key = "infra/ec2/security_group/terraform.tfstate"
        region = "ap-northeast-2"
    }
}

data "terraform_remote_state" "alb" {
    backend = "s3"
    config = {
        bucket = "aws05-terraform-state"
        key = "infra/ec2/alb/terraform.tfstate"
        region = "ap-northeast-2"
    }
}