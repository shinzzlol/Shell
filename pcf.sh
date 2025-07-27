#!/bin/bash

echo "Starting Pterodactyl Installer Script 🚀"
echo "Use your panel hostname, Don't assume SSL, Don't use LetsEncryt, Don't allow firewall too"

sudo bash <(curl -s https://pterodactyl-installer.se)

echo "Making boot certificates 🏓"
mkdir -p /etc/certs
cd /etc/certs
openssl req -new -newkey rsa:4096 -days 3650 -nodes -x509 -subj "/C=NA/ST=NA/L=NA/O=NA/CN=Generic SSL Certificate" -keyout privkey.pem -out fullchain.pem

echo "Installing Cloudflared Tunnel Dependencies 💻"
# Add cloudflare gpg key
sudo mkdir -p --mode=0755 /usr/share/keyrings
curl -fsSL https://pkg.cloudflare.com/cloudflare-main.gpg | sudo tee /usr/share/keyrings/cloudflare-main.gpg >/dev/null

# Add this repo to your apt repositories
echo 'deb [signed-by=/usr/share/keyrings/cloudflare-main.gpg] https://pkg.cloudflare.com/cloudflared any main' | sudo tee /etc/apt/sources.list.d/cloudflared.list

# install cloudflared
sudo apt-get update && sudo apt-get install cloudflared

echo "Create a tunnel in Zero Trust and copy the auth command and paste it and your work is done ✨"
echo "Make a pubic hostname with http service, that must forward to 80"
echo "Make a pubic hostname with https service, that must forward to 8443 with NoTLS Verify."
echo "Configure the node and then your done!"
