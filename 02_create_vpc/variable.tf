variable "vpc_cidr" {
  default = "10.5.0.0/16"
}

variable "public_subnet" {
  type    = list(any)
  default = ["10.5.0.0/20", "10.5.16.0/20"]
}

variable "private_subnet" {
  type    = list(any)
  default = ["10.5.64.0/20", "10.5.80.0/20"]
}

variable "azs" {
  type    = list(any)
  default = ["ap-northeast-2a", "ap-northeast-2c"]
}