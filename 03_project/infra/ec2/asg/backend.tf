terraform {
    backend "s3" {
      bucket = "aws05-terraform-state"
      region = "ap-northeast-2"
      key = "infra/ec2/asg/terraform.tfstate"
      dynamodb_table = "aws05-terraform-locks"
      encrypt  = true
    }
}