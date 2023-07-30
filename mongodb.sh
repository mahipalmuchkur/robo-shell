echo -e  "\e[36m>>>>>>> Creating Mongo Repo files <<<<<<<<<<<<<<<<<\e[0m"
cp mongo.repo /etc/yum.repos.d/mongo.repo
echo -e  "\e[36m>>>>>>> Installing MongoDB Client <<<<<<<<<<<<<<<<<\e[0m"
yum install mongodb-org -y

# Update listen address from 127.0.0.1 to 0.0.0.0
echo -e  "\e[36m>>>>>>> Updating MongoDB Ports <<<<<<<<<<<<<<<<<\e[0m"
sed -i 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf
echo -e  "\e[36m>>>>>>> Starting MongoDB Service <<<<<<<<<<<<<<<<<\e[0m"
systemctl enable mongod
systemctl restart mongod ; tail -f /var/log/messages
