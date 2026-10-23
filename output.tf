output "ec2_public_ip" {
  value = aws_instance.inst1.public_ip
}