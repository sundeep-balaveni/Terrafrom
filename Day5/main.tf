provider "aws"{
    region = "ap-south-1"
  
}
variable "cidr" {
    default = "172.31.1.0/24" 
}
resource "aws_key_pair" "Keypair" {

    key_name = "python-module-key-pair"
    public_key = file("~/.ssh/id_rsa.pub") 
}
resource "aws_vpc" "myvpc" {
    cidr_block = var.cidr
}

resource "aws_security_group" "my_sg" {
  name        = "allow-ssh"
  description = "Allow SSH access"
  vpc_id      = aws_vpc.myvpc.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

ingress {
    description = "HTTP from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Allow-SSH"
  }
}


resource "aws_internet_gateway" "igw" {

    vpc_id = aws_vpc.myvpc.id
}



// Route Table
resource "aws_route_table" "my_route_table" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "My-Route-Table"
  }
}

resource "aws_route_table_association" "rta1" {
    subnet_id = aws_subnet.sub1.id
    route_table_id = aws_route_table.my_route_table.id

  
}



resource "aws_subnet" "sub1" {

    vpc_id = aws_vpc.myvpc.id
    cidr_block = "172.31.1.0/28" 
    availability_zone = "ap-south-1a"  
}


resource "aws_instance" "server" {

    ami = "ami-0f918f7e67a3323f0"
    instance_type = "t2.micro"
    key_name = aws_key_pair.Keypair.key_name
    vpc_security_group_ids = [aws_security_group.my_sg.id]
    subnet_id = aws_subnet.sub1.id
    associate_public_ip_address = true  # ✅ This is required!

    tags = {
  Name = "python-app-Server"
}

    connection {
    type        = "ssh"
    user        = "ubuntu"  # Replace with the appropriate username for your EC2 instance
    private_key = file("~/.ssh/id_rsa")  # Replace with the path to your private key
    host        = self.public_ip
  }

   provisioner "file" {
    source      = "C:/Users/Lenovo/Downloads/DEVOPS/Teraform/Day5/app.py"  # Replace with the path to your local file
    destination = "/home/ubuntu/app.py"  # Replace with the path on the remote instance
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'Hello from the remote instance'",
      "sudo apt update -y",  # Update package lists (for ubuntu)
      "sudo apt-get install -y python3-pip",  # Example package installation
      "cd /home/ubuntu",
      "sudo pip3 install flask",
      "sudo python3 app.py &",
      "nohup python3 app.py > app.log 2>&1 &"  
    ]
  }
  
}

