#! /bin/bash

sudo apt update
sudo apt install git zip unzip apache2  -y
systemctl enable apache2
wget https://www.tooplate.com/zip-templates/2117_infinite_loop.zip
unzip -o 2117_infinite_loop.zip
cp -r 2117_infinite_loop/* /var/www/html
systemctl restart apache2