variable "web_port" {
    description = "The port will use for HTTP 80 requests"
    type = number
    default = 80
}

variable "ssh_port" {
    description = "The port will use for HTTP requests"
    type = number
    default = 22
}

variable "https_port" {
    description = "The port will use for HTTPS requests"
    type = number
    default = 443
}

variable "target_port" {
    description = "The port will use for HTTP 8080 requests"
    type = number
    default = 8080
}