resource "aws_lb_target_group" "app_tg" {
  name     = "app-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.app_vpc.id

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 2
  }

  tags = {
    Name = "AppTargetGroup"
  }
}

resource "aws_lb_target_group_attachment" "tg_attachment" {
  for_each          = aws_instance.app_instance  # Loop through each instance
  target_group_arn  = aws_lb_target_group.app_tg.arn
  target_id         = each.value.id
  port              = 80
}