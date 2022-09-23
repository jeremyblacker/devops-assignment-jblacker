variable "aws_region" {
  description = "EC2 Region for the VPC"
  type        = string
  default     = "us-east-1"
}

variable "common_tags" {
  description = "A map of tags to use on all resources"
  type        = map(string)
  default     = {
    "creator" = "jblacker"
    "project" = "whats_my_ip"
  }
}
