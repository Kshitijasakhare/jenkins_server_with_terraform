data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }
}
resource "aws_instance" "inst1" {
  instance_type               = "t3.micro"
  availability_zone           = var.az
  ami                         = data.aws_ami.amazon_linux_2023.id
  key_name                    = "mumkey2"
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.pubsub.id
  vpc_security_group_ids      = [aws_default_security_group.sg.id]
  user_data                   = file("jenkins_script.sh")
  tags = {
    Name = "Inst1"
  }
}