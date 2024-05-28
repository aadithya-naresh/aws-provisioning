resource "local_sensitive_file" "private_key" {
  content  = tls_private_key.example.private_key_pem
  filename          = format("%s/%s/%s", abspath(path.root), ".ssh", "ansible-ssh-key.pem")
  file_permission   = "0600"
}

resource "local_file" "ansible_inventory" {
  content = templatefile("inventory.tftpl", {
    ip_addrs = [for i in aws_instance.instance: i.public_ip]
    # ssh_keyfile = local_sensitive_file.private_key.filename
    ssh_keyfile = "~/ansible-ssh-key.pem"
  })
  filename = format("%s/%s/%s", abspath(path.root), "../ansible/", "inventory.ini")
}
