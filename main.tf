provider "aws" {
  region     = "us-east-1"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
}

resource "aws_instance" "instance" {
  ami                    = "ami-07caf09b362be10b8"
  instance_type          = "t2.micro"
  key_name               = "ESGI"
  associate_public_ip_address = true

connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("./.ssh/ESGI.pem")
    host        = self.public_ip
  }
}