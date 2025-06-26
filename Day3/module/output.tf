output "public-ip-address" {

    value = aws_instance.first-instance.public_ip
  
}