cp nginx-roboshop.conf /etc/nginx/default.d/roboshop.conf
echo -e "\e[31m>>>>>>>>>>>>>>>>>>>>> Installing Nginx Server <<<<<<<<<<<<<<<<<<<<<<\e[0m"
yum install nginx -y
echo -e "\e[32m>>>>>>>>>>>>>>>>>>>>> Enabiling Starting Nginx Server <<<<<<<<<<<<<<<<<<<<<<\e[0m"
systemctl enable nginx
systemctl start nginx

rm -rf /usr/share/nginx/html/*
echo -e "\e[33m>>>>>>>>>>>>>>>>>>>>> Downloading roboshop files <<<<<<<<<<<<<<<<<<<<<<\e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip
echo -e "\e[34m>>>>>>>>>>>>>>>>>>>>> Extracting and unzipping <<<<<<<<<<<<<<<<<<<<<<\e[0m"
cd /usr/share/nginx/html
unzip /tmp/frontend.zip
echo -e "\e[35m>>>>>>>>>>>>>>>>>>>>> Enabiling Restarting Nginx Server <<<<<<<<<<<<<<<<<<<<<<\e[0m"
systemctl enable nginx
systemctl restart nginx ; tail -f /var/log/messages