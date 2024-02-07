provider "local" {}
variable "names" {
  description = "A list of names"
  type        = list(string)
  default     = ["neo", "trinity", "morpheus"]
}

output "for_directive" {
  value = <<EOF
%{~ for name in var.names }
    ${name}
%{~ endfor }
EOF  
}