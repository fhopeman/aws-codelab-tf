#!/bin/bash

echo "Update packages"
sudo yum update -y

echo "Install nginx"
sudo amazon-linux-extras install nginx1.12

echo "Configure nginx: Add location to default config on port 80"
sudo cat > /etc/nginx/default.d/service1.conf << 'EOF'
  location /service1/health {
    return 200 'Hallo Welt! ec2-instance-asg-alb\nIP: $server_addr\nHostname: $hostname\n';
    add_header Content-Type text/plain;
  }
EOF

echo "Restart nginx"
sudo service nginx restart
