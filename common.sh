status_check() {
   if [ $? -eq 0 ]; then
      echo "success"
   else
      echo "failure"
      exit 1
   fi
}
color="\e[31m"
log_file="/tmp/expense.log"
