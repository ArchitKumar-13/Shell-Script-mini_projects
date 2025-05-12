#!/bin/bash

read -p "Enter your Website: " W
read -p "Enter Document Root: " DR

if [ `rpm -q httpd` ] > /dev/null 2>&1
then
    echo " \"httpd\" package is installed "
else
    echo " \"httpd\" package is not installed "

    echo " \"httpd\" package is installing... "
    yum install httpd -y &>/dev/null
    systemctl enable --now httpd &>/dev/null
    echo " \"httpd\" package, Successfully installed"
fi

mkdir -p "$DR"

cat >> /etc/httpd/conf.d/"$W.conf" <<EOF
<VirtualHost *:80>
ServerName $W
DocumentRoot $DR
ErrorLog logs/error-$W.log
CustomLog logs/$W.log common
</VirtualHost>
EOF

echo "Server Installed for $W" > "$DR/index.html"
systemctl restart httpd 