#!/bin/bash -xe
yum install -y docker
service docker start
docker run -dp 8080:8080 felixb/yocto-httpd
