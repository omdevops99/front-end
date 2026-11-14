source common.sh

if [ -z "$1" ]; then
   echo "password input missing"
   exit 1
fi
MYSQL_ROOT_PASSWORD=$1


echo -e "${color} disable nodejs \e[0m"
dnf module disable nodejs -y &>>${log_file}
status_check


echo -e "${color}  enable nodejs nginx\e[0m"
dnf module enable nodejs:18 -y &>>${log_file}
status_check

echo -e "${color} installing nodejs \e[0m"
dnf install nodejs -y &>>${log_file}
status_check

echo -e "${color} cp backend.service to the systemd \e[0m"
cp backend.service /etc/systemd/system/backend.service &>>${log_file}
status_check



id expense &>>${log_file}
if  [ $? -ne 0 ]; then
 echo -e "${color} Adding the expense user \e[0m"
 useradd expense &>>${log_file}
 status_check
fi

if [ ! -d /app ]; then
  echo -e "${color} create the  /app \e[0m" 
  mkdir /app  &>>${log_file}
  status_check
fi

echo -e "${color} downloasd & extract teh backebd.zip \e[0m"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip  &>>${log_file}
status_check

echo -e "${color} change the directory \e[0m"
cd /app  &>>${log_file}
status_check

echo -e "${color} unzip the file \e[0m"
unzip -o /tmp/backend.zip &>>${log_file}
status_check

echo -e "${color} npm nodejs dependency \e[0m"
npm install  &>>${log_file}
status_check

echo -e "${color} deamon reload \e[0m"
systemctl daemon-reload &>>${log_file}
status_check

echo -e "${color} enable the baclede service \e[0m"
systemctl enable backend  &>>${log_file}
status_check

echo -e "${color} restart the backend service \e[0m"
systemctl restart backend   &>>${log_file}
status_check

echo -e "${color} install the mysql service \e[0m"
dnf install mysql -y &>>${log_file}
status_check

echo -e "${color} create the password\e[0m"
mysql -h 172.31.31.122 -uroot -p${MYSQL_ROOT_PASSWORD} < /app/schema/backend.sql   &>>${log_file}
status_check
