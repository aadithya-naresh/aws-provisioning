resource "local_sensitive_file" "private_key" {
  content  = tls_private_key.example.private_key_pem
  filename          = format("%s/%s/%s", abspath(path.root), ".ssh", "ansible-ssh-key.pem")
  file_permission   = "0600"
}

resource "local_file" "ansible_inventory" {
  content = templatefile("inventory.tftpl", {
    # ssh_keyfile = local_sensitive_file.private_key.filename
    ip_addrs = [for i in aws_instance.instance: i.public_ip]
    ssh_keyfile = "~/ansible-ssh-key.pem"
    rds_endpoint = aws_db_instance.default.endpoint
    rds_port = aws_db_instance.default.port
    rds_username = aws_db_instance.default.username
    rds_db_name = aws_db_instance.default.db_name
    rds_password = var.rds_password
  })
  filename = format("%s/%s/%s", abspath(path.root), "../ansible/", "inventory.ini")
}
