source common.sh

echo -e "${color} installing nginx\e[0m"
dnf install nginx -y &>>${log_file}
status_check


echo -e "${color} enabling the nginx\e[0m"
systemctl enable nginx &>>${log_file}
status_check

echo -e "${color} starting the nignx \e[0m"
systemctl start nginx  &>>${log_file}
status_check
echo -e "${color}copy the expense.conf \e[0m"
cp expense.conf /etc/nginx/default.d/expense.conf  &>>${log_file}
status_check

echo -e "${color} remove the user details \e[0m"
rm -rf /usr/share/nginx/html/* &>>${log_file}
status_check

echo -e "${color}  extracting the file \e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip  &>>${log_file}
status_check


echo -e "${color} change the directory \e[0m"

cd /usr/share/nginx/html  &>>${log_file}
status_check


echo -e "${color} unzip the file \e[0m"
unzip /tmp/frontend.zip &>>${log_file}
status_check

echo -e "${color} restart the nginx \e[0m"
status_check

systemctl restart nginx  &>>${log_file}
status_check
