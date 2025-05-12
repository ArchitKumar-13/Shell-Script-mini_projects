#!/bin/bash
read -p "Give your website name: " URL

# Extract the domain name prefix for directory naming
DR=$(echo $URL | cut -c 1-8)

# Create the website directory
mkdir -p /var/www/$DR
echo "test website" > /var/www/$DR/index.html # Added index.html file
chown -R www-data:www-data /var/www/$DR # Changed the ownership of the document-root to apache user.

# Create a virtual host configuration file
cat >> /etc/apache2/sites-enabled/$DR.conf << EOF
<virtualhost *:80>
servername $URL
documentroot /var/www/$DR
errorlog \${APACHE_LOG_DIR}/$URL-error.log
customlog \${APACHE_LOG_DIR}/$URL.log common

<directory "/var/www/$DR">
	Options FollowSymLinks
	AllowOverride All
	Require all granted
</directory>

</virtualhost>
EOF

# Restart the HTTP server
systemctl restart httpd

# Successfully installed...
echo "!!!...WebServer Installation Successfully done...!!!"
