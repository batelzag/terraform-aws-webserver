# The bash script that will run on launch of the WEB instances
locals {
  web-instance-userdata = <<USERDATA
#!/bin/bash

sudo apt update -y
sudo apt install nginx -y
export dnshostname=$(curl http://169.254.169.254/latest/meta-data/public-hostname)
sudo tee /var/www/html/index.html <<EOF
<html>
    <head>
        <title>Welcome to Grandpa's Whiskey</title>
    </head>
    <body style="background-color:rgb(252, 178, 227);">
        <h1 style="font-size:40px;">Welcome to Grandpa's Whiskey</h1>
        <img src="https://heavy.com/wp-content/uploads/2012/12/drunk-grandpa.jpg" alt="drunk-grandpa">
        <h2>$dnshostname</h2>
    </body>
</html>
EOF
service nginx restart
sudo apt install awscli -y
mkdir scripts
tee /scripts/upload-accesslog.sh <<EOF
#!/bin/bash

aws s3 cp /var/log/nginx/access.log s3://whiskey-access-logs/$(hostname)/
EOF
chmod +x /scripts/upload-accesslog.sh
echo "0 * * * * /scripts/upload-accesslog.sh" | crontab - ubuntu

USERDATA
}