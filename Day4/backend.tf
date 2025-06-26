terraform {
  backend "s3" {
    bucket = "sandeep-tstate-file"
    region = "ap-south-1"
    key = "ec2/terraform.tfstate"
  }
}
