resource "aws_instance" "app_instance" {
  for_each                  = aws_subnet.public_subnets
  ami                       = var.ami
  instance_type             = var.instance_type
  subnet_id                 = each.value.id
  vpc_security_group_ids    = [aws_security_group.app_sg.id]
  associate_public_ip_address = true
  key_name                  = var.key_name
  user_data                 = file("userdata.sh")  # Optional startup script

  tags = {
    Name = "AppInstance-${each.key + 1}"
  }
}