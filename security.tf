resource "aws_security_group" "alb_sg" {
  name        = "alb-security-group"
  description = "Allow HTTP and HTTPS access"
  vpc_id      = var.vpc_id

  tags = {
    Name = "ALB-SG"
  }
}

resource "aws_security_group_rule" "alb_ingress_http" {
  security_group_id = aws_security_group.alb_sg.id
  type        = "ingress"
  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]  # Allow HTTP from anywhere
}

resource "aws_security_group_rule" "alb_ingress_https" {
  security_group_id = aws_security_group.alb_sg.id
  type        = "ingress"
  from_port   = 443
  to_port     = 443
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]  # Allow HTTPS from anywhere
}

resource "aws_security_group_rule" "alb_egress" {
  security_group_id = aws_security_group.alb_sg.id
  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]  # Allow outbound traffic
}

resource "aws_security_group" "app_sg" {
  name        = "app-instance-sg"
  description = "Allow traffic from ALB"
  vpc_id      = var.vpc_id

  tags = {
    Name = "AppInstanceSG"
  }
}

resource "aws_security_group_rule" "app_sg_ingress" {
  security_group_id = aws_security_group.app_sg.id
  type        = "ingress"
  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  source_security_group_id = aws_security_group.alb_sg.id  # Only allow traffic from ALB
}

resource "aws_security_group_rule" "app_sg_egress" {
  security_group_id = aws_security_group.app_sg.id
  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}