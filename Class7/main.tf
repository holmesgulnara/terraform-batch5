provider "aws" {
  region = "us-east-2"
}

resource "aws_key_pair" "deployer" {
  key_name   = "hello"
  public_key = file("~/.ssh/id_rsa.pub")
}


resource "aws_instance" "web" {
  ami                    = "ami-0900fe555666598a2"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  key_name               = aws_key_pair.deployer.key_name


  #   connection {
  #     type     = "ssh"
  #     user     = "ec2-user"
  #     private_key = file("~/.ssh/id_rsa")
  #     host     = self.public_ip
  #   }


  #THIS WILL COPY THE FILE FROM NASTION'S LOCAL TO THE REMOTE'S LOCAL, IF WE SSH INTO REMOTE AND LS WE CAN SEE THE COPIED FILE
  # provisioner "file" {
  #   source = "./httpd.sh"               #local machine
  #   destination = "./httpd.sh"          #remote machine
  # }

  #   provisioner "remote-exec" {
  #     inline = [ 
  #         "chmod +x httpd.sh",
  #         "./httpd.sh"
  #     ]
  # }


  #THIS WILL NOT COPY THE FILE INSTEAD IT WILL JUST TAKE IT FROM BASTION'S LOCAL AND EXECUTE IT IN REMOTE INSTANCE
  #   provisioner "remote-exec" {
  #     script = "./httpd.sh"
  # }


}

# resource "null_resource" "hello" {
#     provisioner "local-exec" {
#     command = "mkdir kaizen && touch hello"
# }

# }