#!/bin/bash -xe

yum update -y
amazon-linux-extras install -y nginx1
service nginx start
