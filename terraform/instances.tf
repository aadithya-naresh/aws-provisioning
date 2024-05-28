data "aws_ami" "linux_ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*"]
  }
}

resource "tls_private_key" "example" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = "generated_key"
  public_key = tls_private_key.example.public_key_openssh
}


resource "aws_security_group" "ssh_sg" {
  name        = "ssh_sg"
  description = "Security group for SSH access"
  
  # Inbound rule for SSH (port 22) traffic from your IP address
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
   from_port   = 0
   to_port     = 0
   protocol    = "-1"
   cidr_blocks = ["0.0.0.0/0"]
 }
}

resource "aws_instance" "instance" {
  ami = data.aws_ami.linux_ami.id
  instance_type = "t3.micro"
  count = 1
  tags = {
    "Name" = "example"
  }
  key_name = aws_key_pair.generated_key.key_name
  security_groups = ["ssh_sg"]
}
