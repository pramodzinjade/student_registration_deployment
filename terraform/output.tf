#print public ip on terminal
output "public_ip" {
  value = aws_instance.target-server.public_ip
  }