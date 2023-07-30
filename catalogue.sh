echo -e  "\e[36m>>>>>>>Create Catalogue Service <<<<<<<<<<<<<<<<<\e[0 | tee -a /tmp/roboshop.log
cp catalogue.service /etc/systemd/system/catalogue.service &>>/tmp/roboshop.log
echo -e  "\e[36m>>>>>>> Monog DB Repo <<<<<<<<<<<<<<<<<\e[0 | tee -a /tmp/roboshop.log
cp mongo.repo /etc/yum.repos.d/mongo.repo &>>/tmp/roboshop.log
echo -e  "\e[36m>>>>>>> Install NodeJS Repos <<<<<<<<<<<<<<<<<\e[0 | tee -a /tmp/roboshop.log
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>/tmp/roboshop.log
echo -e  "\e[36m>>>>>>> Install NodeJS  <<<<<<<<<<<<<<<<<\e[0 | tee -a /tmp/roboshop.log
yum install nodejs -y &>>/tmp/roboshop.log
echo -e  "\e[36m>>>>>>> Create Application User <<<<<<<<<<<<<<<<<\e[0 | tee -a /tmp/roboshop.log
useradd roboshop &>>/tmp/roboshop.log
echo -e  "\e[31m>>>>>>> Removing Application Directory <<<<<<<<<<<<<<<<<\e[0 | tee -a /tmp/roboshop.log
rm -rf /app
echo -e  "\e[36m>>>>>>> Create Application Directory <<<<<<<<<<<<<<<<<\e[0 | tee -a /tmp/roboshop.log
mkdir /app
echo -e  "\e[36m>>>>>>> Download Application Content <<<<<<<<<<<<<<<<<\e[0 | tee -a /tmp/roboshop.log
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>>/tmp/roboshop.log
echo -e  "\e[36m>>>>>>> Extract Application Content <<<<<<<<<<<<<<<<<\e[0 | tee -a /tmp/roboshop.log
cd /app
unzip /tmp/catalogue.zip &>>/tmp/roboshop.log
cd /app
echo -e  "\e[36m>>>>>>> Download NodeJS Dependencies <<<<<<<<<<<<<<<<<\e[0 | tee -a /tmp/roboshop.log
npm install &>>/tmp/roboshop.log
echo -e  "\e[36m>>>>>>> Install MonogoDB Client <<<<<<<<<<<<<<<<<\e[0 | tee -a /tmp/roboshop.log
yum install mongodb-org-shell -y &>>/tmp/roboshop.log
echo -e  "\e[36m>>>>>>> Load Catalogue Schema <<<<<<<<<<<<<<<<<\e[0 | tee -a /tmp/roboshop.log
mongo --host mongodb.mdevopsb74.online </app/schema/catalogue.js &>>/tmp/roboshop.log
echo -e  "\e[36m>>>>>>> Start Catalogue Service <<<<<<<<<<<<<<<<<\e[0 | tee -a /tmp/roboshop.log
systemctl daemon-reload
systemctl enable catalogue
systemctl restart catalogue ; tail -f /var/log/messages