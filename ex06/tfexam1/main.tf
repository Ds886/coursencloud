provider "aws" {
  region = "us-east-1"
}
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"] # Adjust for your desired version
  }
}

resource "aws_" "name" {

}


resource "aws_instance" "example" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
}

output "instance_ip" {
  value = aws_instance.example.public_ip
}
