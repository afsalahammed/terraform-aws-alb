output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer"
  value       = aws_lb.app_alb.dns_name
}

output "target_group_arn" {
  description = "ARN of the Target Group"
  value       = aws_lb_target_group.app_tg.arn
}

output "alb_listener_arn" {
  description = "ARN of the ALB Listener"
  value       = aws_lb_listener.http_listener.arn
}

output "app_instance_ids" {
  description = "IDs of the application instances"
  value       = aws_instance.app_instance[*].id
}

output "app_instance_public_ips" {
  description = "Public IPs of the application instances"
  value       = aws_instance.app_instance[*].public_ip
}

output "vpc_id" {
  description = "The ID of the created VPC"
  value       = aws_vpc.app_vpc.id
}

output "public_subnet_ids" {
  description = "The IDs of the public subnets"
  value       = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id]
}