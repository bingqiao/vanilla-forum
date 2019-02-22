#!/bin/bash

if [ ! -f /scripts/.mysql_setup ]; then
    echo "setting up mysql................................................."
    mysql_install_db --user=mysql
fi

su - mysql << EOF
  echo "Starting database server to accept connections.................."
  mysqld >/dev/null 2>&1 &
EOF

timeout=30

if [ ! -f /scripts/.mysql_setup ]; then
    echo "Waiting for database server to accept connections.................."
    while ! mysqladmin -u root status >/dev/null 2>&1
    do
      timeout=$(($timeout - 1))
      if [ $timeout -eq 0 ]; then
        echo -e "\nCould not connect to database server. Aborting..."
        exit 1
      fi
      echo -n "."
      sleep 1
    done

    echo "setting up mysql................................................."
    mysqladmin -u root password letmein

    mysql -u root -pletmein -e "create database vanilla_data character set utf8 collate utf8_general_ci"
    mysql -u root -pletmein -e "create user 'vanilla_user'@'localhost' identified by 'letmein';"
    mysql -u root -pletmein -e "grant all privileges on vanilla_data.* to 'vanilla_user'@'localhost'"
    mysql -u root -pletmein -e "flush privileges"

    touch /scripts/.mysql_setup
fi

echo "Waiting for database server to accept connections.................."
while ! mysqladmin -u root -pletmein status >/dev/null 2>&1
do
  timeout=$(($timeout - 1))
  if [ $timeout -eq 0 ]; then
    echo -e "\nCould not connect to database server. Aborting..."
    exit 1
  fi
  echo -n "."
  sleep 1
done

echo "Starting apache.................."
apachectl

# stop container quitting
/bin/bash