resource "aws_instance" "app_instance" {
  count                  = 2  # Deploys two instances
  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = element(var.public_subnets, count.index)
  vpc_security_group_ids = [aws_security_group.app_sg.id]
  key_name               = var.key_name
  user_data              = file("userdata.sh")  # Optional: Auto-configure the app

  tags = {
    Name = "AppInstance-${count.index + 1}"
  }
}