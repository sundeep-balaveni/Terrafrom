# # provider "aws" {
# #   alias = "south"
# #   region = "ap-south-1"  # Set your desired AWS region
# # }

# # provider "aws" {
# #   alias = "west"
# #   region = "us-west-2"  # Set your desired AWS region
# # }

# # resource "aws_instance" "example1" {
# #   ami           = var.ami_num  # Specify an appropriate AMI ID
# #   instance_type = "t2.micro"
# #   //subnet_id = "subnet-0924b56721fa58a6c"
# #   key_name = "P1"
# #   provider = aws.south
# #   tags = {
# #     Name = "P3"  
# #   }
# # }

# # resource "aws_instance" "example2" {
# #   ami           = var.ami_num_west  # Specify an appropriate AMI ID
# #   instance_type = "t2.micro"
# #   //subnet_id = "subnet-0924b56721fa58a6c"
# #  // key_name = "P1"
# #   provider = aws.west
# #   tags = {
# #     Name = "P4"  
# #   }
# # }



# provider "aws" {
#   region = "ap-south-1"
# }

# resource "aws_s3_bucket" "test-bucket-2" {

#   bucket = "testbucket0012300"
#   tags = {Name = "test_bucket"}

# }
