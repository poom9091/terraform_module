resource "aws_instance" "database" {
  ami           = var.ami
  instance_type = var.instance_type

  user_data                   = base64encode(data.template_file.postgresql.rendered)
  subnet_id                   = var.subnet_id
  key_name                    = "tf-key-pair"
  associate_public_ip_address = true
  security_groups             = [module.database_security_group.securiyt_group_id]
  tags = {
    Name = "${var.environment}-${var.server_name}"
  }
}

data "template_file" "postgresql" {
  template = <<EOT
#!/bin/bash
sh -c 'echo "deb https://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
apt-get update
apt-get -y install postgresql
sudo -u postgres psql -c "ALTER USER postgres WITH PASSWORD 'postgres';"
cat <<'EOF' >> /etc/postgresql/16/main/pg_hba.conf
host    all     all             0.0.0.0/0               scram-sha-256
EOF
cat <<'EOF' >> /etc/postgresql/16/main/postgresql.conf
listen_addresses = '*'
EOF
systemctl restart postgresql
EOT
}

resource "aws_key_pair" "tf-key-pair" {
  key_name   = "tf-key-pair"
  public_key = tls_private_key.rsa.public_key_openssh
}

resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "tf-key" {
  content  = tls_private_key.rsa.private_key_pem
  filename = "tf-key-pair"
}
