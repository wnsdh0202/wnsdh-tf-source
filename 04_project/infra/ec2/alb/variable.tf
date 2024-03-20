variable "target-port" {
  description = "The port will use for HTTP 8080 requests"
  type        = number
  default     = 8080
}

variable "http-port" {
  description = "The port will use for HTTP 80 requests"
  type        = number
  default     = 80
}

variable "alb-arn" {
  description = "alb-arn"
  type = string
  default = "arn:aws:elasticloadbalancing:ap-northeast-2:257307634175:loadbalancer/app/k8s-default-ingresst-a30572d631/f911362a6e8d25c7"
}

variable "alb-dns-name" {
  description = "alb-dns-name"
  type = string
  default = "k8s-default-ingresst-a30572d631-1778449461.ap-northeast-2.elb.amazonaws.com"
}