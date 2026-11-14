source common.sh
if [ -z "$1" ]; then
   echo password input missing
   exit
fi

MYSQL_ROOT_PASSWORD=$1

echo -e "${color} disable mysql \e[0m"
dnf module disable mysql -y &>>${log_file}
status_check
echo -e "${color} cp the mysql repo \e[0m"
cp mysql.repo /etc/yum.repos.d/mysql.repo  &>>${log_file}
status_check

echo -e "${color} install the mysql community server \e[0m"
dnf install mysql-community-server -y &>>${log_file}
status_check
echo -e "${color} enable the mysqld \e[0m"
systemctl enable mysqld &>>${log_file}
status_check
echo -e "${color} start the mysqld \e[0m"
systemctl start mysqld   &>>${log_file}
status_check

echo -e "${color} set the password \e[0m"
mysql_secure_installation --set-root-pass "${MYSQL_ROOT_PASSWORD}" &>>${log_file}

status_check