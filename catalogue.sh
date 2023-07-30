echo -e  "\e[36m>>>>>>>Create Catalogue Service <<<<<<<<<<<<<<<<<\e[0m"
cp catalogue.service /etc/systemd/system/catalogue.service
echo -e  "\e[36m>>>>>>> Monog DB Repo <<<<<<<<<<<<<<<<<\e[0m"
cp mongo.repo /etc/yum.repos.d/mongo.repo
echo -e  "\e[36m>>>>>>> Install NodeJS Repos <<<<<<<<<<<<<<<<<\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash
echo -e  "\e[36m>>>>>>> Install NodeJS  <<<<<<<<<<<<<<<<<\e[0m"
yum install nodejs -y
echo -e  "\e[36m>>>>>>> Create Application User <<<<<<<<<<<<<<<<<\e[0m"
useradd roboshop
echo -e  "\e[31m>>>>>>> Removing Application Directory <<<<<<<<<<<<<<<<<\e[0m"
rm -rf /app
echo -e  "\e[36m>>>>>>> Create Application Directory <<<<<<<<<<<<<<<<<\e[0m"
mkdir /app
echo -e  "\e[36m>>>>>>> Download Application Content <<<<<<<<<<<<<<<<<\e[0m"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip
echo -e  "\e[36m>>>>>>> Extract Application Content <<<<<<<<<<<<<<<<<\e[0m"
cd /app
unzip /tmp/catalogue.zip
cd /app
echo -e  "\e[36m>>>>>>> Download NodeJS Dependencies <<<<<<<<<<<<<<<<<\e[0m"
npm install
echo -e  "\e[36m>>>>>>> Install MonogoDB Client <<<<<<<<<<<<<<<<<\e[0m"
yum install mongodb-org-shell -y
echo -e  "\e[36m>>>>>>> Load Catalogue Schema <<<<<<<<<<<<<<<<<\e[0m"
mongo --host mongodb.mdevopsb74.online </app/schema/catalogue.js
echo -e  "\e[36m>>>>>>> Start Catalogue Service <<<<<<<<<<<<<<<<<\e[0m"
systemctl daemon-reload
systemctl enable catalogue
systemctl restart catalogue ; tail -f /var/log/messages