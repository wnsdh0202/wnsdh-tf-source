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