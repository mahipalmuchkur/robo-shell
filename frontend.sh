cp nginx-roboshop.conf /etc/nginx/default.d/roboshop.conf
echo ">>>>>>>>>>>>>>>>>>>>> Installing Nginx Server <<<<<<<<<<<<<<<<<<<<<<"
yum install nginx -y
echo ">>>>>>>>>>>>>>>>>>>>> Enabiling Starting Nginx Server <<<<<<<<<<<<<<<<<<<<<<"
systemctl enable nginx
systemctl start nginx

rm -rf /usr/share/nginx/html/*
echo ">>>>>>>>>>>>>>>>>>>>> Downloading roboshop files <<<<<<<<<<<<<<<<<<<<<<"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip
echo ">>>>>>>>>>>>>>>>>>>>> Extracting and unzipping <<<<<<<<<<<<<<<<<<<<<<"
cd /usr/share/nginx/html
unzip /tmp/frontend.zip
echo ">>>>>>>>>>>>>>>>>>>>> Enabiling Restarting Nginx Server <<<<<<<<<<<<<<<<<<<<<<"
systemctl enable nginx
systemctl restart nginx ; tail -f /var/log/messages