provider "aws" {
    region = "ap-northeast-2"
}

# 기본 vpc 정보
data "aws_vpc" "default" {
    filter {
        name = "tag:Name"
        values = ["aws05-vpc"]
    }
}

# subnet 정보
data "aws_subnets" "example" {
    filter {
    name = "vpc-id" // output의 이름
    values = [data.aws_vpc.default.id]
    }
}

# subnet 정보의 집합자료형 화
data "aws_subnet" "example" {
    for_each = toset(data.aws_subnets.example.ids)
    id = each.value
}

# default vpc id 출력
output "vpc-id" {
    value = data.aws_vpc.default.id
}

# subnet cidr_block 출력
output "subnet_cidr_blocks" {
    value = [ for s in data.aws_subnet.example : s.cidr_block]
}