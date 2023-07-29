cp nginx-roboshop.conf /etc/nginx/default.d/roboshop.conf
echo ">>>>>>>>>>>>>>>>>>>>> Installing Nginx Server <<<<<<<<<<<<<<<<<<<<<<"
yum install nginx -y
echo ">>>>>>>>>>>>>>>>>>>>> Enabiling Nginx Server <<<<<<<<<<<<<<<<<<<<<<"
systemctl enable nginx
echo ">>>>>>>>>>>>>>>>>>>>> Starting Nginx Server <<<<<<<<<<<<<<<<<<<<<<"
systemctl start nginx

echo ">>>>>>>>>>>>>>>>>>>>> Removing junk files <<<<<<<<<<<<<<<<<<<<<<"
rm -rf /usr/share/nginx/html/*
echo ">>>>>>>>>>>>>>>>>>>>> Roboshop Artifacts <<<<<<<<<<<<<<<<<<<<<<"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip
echo ">>>>>>>>>>>>>>>>>>>>> Entering in to repository <<<<<<<<<<<<<<<<<<<<<<"
cd /usr/share/nginx/html
unzip /tmp/frontend.zip
echo ">>>>>>>>>>>>>>>>>>>>> Enabiling Nginx Server <<<<<<<<<<<<<<<<<<<<<<"
systemctl enable nginx
echo ">>>>>>>>>>>>>>>>>>>>> Restarting Nginx Server <<<<<<<<<<<<<<<<<<<<<<"
systemctl restart nginx ; tail -f /var/log/messages