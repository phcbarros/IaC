#!/bin/bash
cd /home/ubuntu
echo "<h1>Feito com terraform</h1>" > index.html
nohup busybox httpd -f -p 8080 &