variable "aws_region" {
  description = "AWS region to deploy resources"
  default     = "us-east-1"
}

variable "vpc_id" {
  description = "VPC ID where the ALB will be deployed"
}

variable "public_subnets" {
  description = "List of public subnet IDs for the ALB"
  type        = list(string)
}
