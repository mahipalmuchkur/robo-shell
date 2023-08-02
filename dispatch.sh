echo -e ">>>>>>>>>>>>>>>>>>>>create dispatch service<<<<<<<<<<<<<<<"
cp dispatch.service /etc/systemd/system/dispatch.service &>>/tmp/roboshop.log
echo -e ">>>>>>>>>>>>>>>>>>>>install golang<<<<<<<<<<<<<<<"
yum install golang -y &>>/tmp/roboshop.log
echo -e ">>>>>>>>>>>>>>>>>>>>creating application directory<<<<<<<<<<<<<<<"
useradd roboshop &>>/tmp/roboshop.log
echo -e ">>>>>>>>>>>>>>>>>>>>cleanup existing application content<<<<<<<<<<<<<<<"
rm -rf /app &>>/tmp/roboshop.log
echo -e ">>>>>>>>>>>>>>>>>>>>create application directory<<<<<<<<<<<<<<<"
mkdir /app &>>/tmp/roboshop.log
echo -e ">>>>>>>>>>>>>>>>>>>>download application content<<<<<<<<<<<<<<<"
curl -L -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch.zip &>>/tmp/roboshop.log
echo -e ">>>>>>>>>>>>>>>>>>>>extract application content<<<<<<<<<<<<<<<"
cd /app &>>/tmp/roboshop.log
unzip /tmp/dispatch.zip &>>/tmp/roboshop.log
cd /app &>>/tmp/roboshop.log
echo -e ">>>>>>>>>>>>>>>>>>>>dispatch and build content<<<<<<<<<<<<<<<"
go mod init dispatch &>>/tmp/roboshop.log
go get &>>/tmp/roboshop.log
go build &>>/tmp/roboshop.log
echo -e ">>>>>>>>>>>>>>>>>>>>start dispatch service<<<<<<<<<<<<<<<"
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable dispatch &>>/tmp/roboshop.log
systemctl restart dispatch ; tail -f /var/log/messages