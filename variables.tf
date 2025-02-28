variable "aws_region" {
  description = "AWS region to deploy resources"
  default     = "ap-south-1"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr_1" {
  description = "CIDR block for the first public subnet"
  default     = "10.0.1.0/24"
}

variable "public_subnet_cidr_2" {
  description = "CIDR block for the second public subnet"
  default     = "10.0.2.0/24"
}

variable "ami" {
  description = "AMI ID for the EC2 instances"
  default     = "ami-00bb6a80f01f03502"  # Update with a valid AMI ID of your region
}

variable "instance_type" {
  description = "Instance type for the EC2 instances"
  default     = "t2.micro"
}

variable "key_name" {
  description = "Name of the SSH key pair for EC2 access"
  sensitive   = true  # Hides the key name from logs
}