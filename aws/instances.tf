data "aws_ami" "linux_ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*"]
  }
}

resource "aws_key_pair" "ssh-key" {
  key_name   = "ssh-key"
  public_key = file(var.ssh_public_key_path)
}

resource "aws_instance" "example_server" {
  ami = data.aws_ami.linux_ami.id
  instance_type = "t2.micro"
  count = 5
  tags = {
    Name = "Ansible-Project"
  }
  key_name = "ssh-key"
}

output "instance_ip" {
  description = "The public ip for ssh access"
  value       = [for instance in aws_instance.instance : instance.public_ip]
}