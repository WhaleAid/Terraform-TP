
resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = file(var.path_public_key)
}

resource "aws_instance" "instance" {
  ami           = "ami-07caf09b362be10b8"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.deployer.key_name


  vpc_security_group_ids = [aws_security_group.instance.id]

}


resource "null_resource" "name" {
  connection {
    type        = "ssh"
    user        = "ec2-user"
    host        = aws_instance.instance.public_ip
    private_key = file(var.path_private_key)
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

  depends_on = [aws_instance.instance]
}
