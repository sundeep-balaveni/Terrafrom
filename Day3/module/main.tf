
provider "aws" {
    region = "ap-south-1"
  
}
resource "aws_instance" "first-instance" {
    ami = var.ami_value
    instance_type = var.instance_type
}