provider "aws" {
    region = "ap-south-1"
}

module "ec2_instance" {
    source = "./module"
    ami_value = "ami-0f918f7e67a3323f0"
    instance_type = "t2.micro" 
}