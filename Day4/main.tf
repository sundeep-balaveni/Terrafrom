provider "aws" {
    region = "ap-south-1" 
}
resource "aws_instance" "Sandeep" {

    instance_type = "t2.micro"
    ami = "ami-0f918f7e67a3323f0"
  
}
# resource "aws_s3_bucket" "s3_bucket" {
#     bucket = "sandeep-tstate-file" 
# }