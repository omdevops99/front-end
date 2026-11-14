source common.sh

if [ -z "$1" ]; then
   echo "password input missing"
   exit 1
fi
MYSQL_ROOT_PASSWORD=$1

echo -e "${color} install mysql server \e[0m"
dnf install mysql-server -y &>>${log_file}
status_check

echo -e "${color} enable mysqld \e[0m"
systemctl enable mysqld &>>${log_file}
status_check

echo -e "${color} start mysqld \e[0m"
systemctl start mysqld &>>${log_file}
status_check

echo -e "${color} set the root password \e[0m"
mysql_secure_installation --set-root-pass "${MYSQL_ROOT_PASSWORD}" &>>${log_file}
status_check