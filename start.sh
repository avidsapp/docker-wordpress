#!/bin/bash

# Start this with "source ./start.sh"
echo set -a

# Check if .env file exists
if [ -e .env ]; then
    source .env
else
    cp .env.sample .env
    echo "Your environment is not set up. A copy of the .env file has been created for you. Change the environment variables before starting your environment or enter them from the command line the next time you start your environment."
    exit
fi

# Check if env variables are empty or default values
if [ -z "$SITE" ]; then
    read -p  "Enter SITE:" input1
    export SITE=$input1
elif [ "$SITE" == "domain.com" ]; then
    read -p  "Enter SITE:" input1
    export SITE=$input1
fi

if [ -z "$NETWORK" ]; then
    read -p  "Enter NETWORK:" input2
    export NETWORK=$input2
fi

if [ -z "$MYSQL_ROOT_PASSWORD" ]; then
    read -p  "Enter MYSQL_ROOT_PASSWORD:" input3
    export MYSQL_ROOT_PASSWORD=$input3
elif [ "$MYSQL_ROOT_PASSWORD" == "root_password" ]; then
    read -p  "Enter MYSQL_ROOT_PASSWORD:" input3
    export MYSQL_ROOT_PASSWORD=$input3
fi

if [ -z "$MYSQL_DATABASE" ]; then
    read -p  "Enter MYSQL_DATABASE:" input4
    export MYSQL_DATABASE=$input4
elif [ "$MYSQL_DATABASE" == "database_name" ]; then
    read -p  "Enter MYSQL_DATABASE:" input4
    export MYSQL_DATABASE=$input4
fi

if [ -z "$MYSQL_USER" ]; then
    read -p  "Enter MYSQL_USER:" input5
    export MYSQL_USER=$input5
elif [ "$MYSQL_USER" == "user_name" ]; then
    read -p  "Enter MYSQL_USER:" input5
    export MYSQL_USER=$input5
fi

if [ -z "$MYSQL_PASSWORD" ]; then
    read -p  "Enter MYSQL_PASSWORD:" input6
    export MYSQL_PASSWORD=$input6
elif [ "$MYSQL_PASSWORD" == "user_password" ]; then
    read -p  "Enter MYSQL_PASSWORD:" input6
    export MYSQL_PASSWORD=$input6
fi

if [ -z "$LETSENCRYPT_EMAIL" ]; then
    read -p  "LETSENCRYPT_EMAIL:" input7
    export LETSENCRYPT_EMAIL=$input7
elif [ "$LETSENCRYPT_EMAIL" == "your_email@domain.com" ]; then
    read -p  "Enter LETSENCRYPT_EMAIL:" input7
    export LETSENCRYPT_EMAIL=$input7
fi

# Create docker network if not already created
if [[ "$(docker network ls | grep proxy 2> /dev/null)" == "" ]]; then
    docker network create proxy -d bridge
fi

# Go through each folder and spin up the docker-compose stack
for d in `ls -d */`; do
    ( cd $d && docker-compose up -d )
done

exit
