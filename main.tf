resource "aws_instance" "instance" {
  ami                         = "ami-07caf09b362be10b8"
  instance_type               = "t2.micro"
  key_name                    = "esgi"
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.instance.id]
  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("./.keys/esgi.pem")
    host        = self.public_ip
  }

  provisioner "file" {
    source      = "./ssh/init.sh"
    destination = "/tmp/init.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/init.sh",
      "/tmp/init.sh"
    ]
  }
}
