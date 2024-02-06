variable "user_names" {
  description = "Create IAM users with these names"
  type        = list(string)
  default     = ["aws05-neo", "aws05-trinity", "aws05-morpheus"]
}