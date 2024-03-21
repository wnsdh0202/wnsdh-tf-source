variable "http_port" {
    description = "The port will use for HTTP 80 requests"
    type = number
    default = 80
}

variable "ssh_port" {
    description = "The port will use for SSH 22 requests"
    type = number
    default = 22
}

variable "https_port" {
    description = "The port will use for HTTPS 443 requests"
    type = number
    default = 443
}

variable "jenkins_port" {
    description = "The port will use for jenkins 8080 requests"
    type = number
    default = 8080
}