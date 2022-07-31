resource "aws_instance" "Django_Production" {
  ami = "ami-006d3995d3a6b963b"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.django_sg.id]
  private_ip = "10.0.100.100"
  subnet_id = aws_subnet.django_subnet.id
  key_name = "django_key"
  associate_public_ip_address = true

  tags = {
    Name = "DjangoServer"
  }
}

resource "aws_key_pair" "django_key" {
  key_name = "django_key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDDUHzaPzqKMoyijWqwZ5pvw1JYP06VY+i5YcP+ZQkl24Btkh0ON90E2AzsUSiKuD3RX//EctlBrJbzWLpGlUAN2jNjeKUrQ2Xi8H1xmk0ekzlAssVdMxE3J/PRfKutaklLfmwDZvW8S12GB/PlvVNKdtX5slVfOwXdWGwLzPPVSqg652c1Rx4xqVhO8jMnoMV+4bI0yNmLTWcbW6UyuH0MvD1DFSQb3AXGt28S7LVm7OMwrscb9mxH9f9vnDsLR7kCv9OooAa85Jl0BDogxDQydWAagCe07OIj6U4miXh7tMwNYpmCDFvaIqNO/qxi0JFzfbdVUhF8SHoQJbGpy+wX"
}


resource "aws_security_group" "django_sg" {
  name = "Security Group for Django Servers"
  vpc_id = aws_vpc.vpc_for_Django.id

  ingress {
    from_port = 8000
    protocol  = "tcp"
    to_port   = 8000
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 443
    protocol  = "tcp"
    to_port   = 443
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    protocol  = "tcp"
    to_port   = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    protocol  = "-1"
    to_port   = 0
    cidr_blocks =  ["0.0.0.0/0"]
  }
}

output "instance_ip" {
  value = aws_instance.Django_Production.public_ip
}

