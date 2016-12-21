#!/bin/bash
########################################
#                                      #
#  Docker-friendly for Ubuntu 14.04    #
#                                      #
########################################

export DEBIAN_FRONTEND=noninteractive
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

readonly COMPOSE_VERSION=1.9.0

INSTALLED=".installed"

# OS Timezone
TIMEZONE="UTC"

# OS pool zone
NTPPOOLZONE="time.stdtime.gov.tw"

# Setup packages and version
PACKAGES_LIST="
unzip
curl
git
php7.0
php7.0-mbstring
php7.0-curl
php7.0-xml
php7.0-mysql
"

PACKAGES=""
for package in $PACKAGES_LIST
do
    PACKAGES="$PACKAGES $package"
done

# is root?
if [ "`whoami`" != "root" ]; then
    echo "You may use root permission!"
    exit 1
fi

if [ ! -e ${INSTALLED} ];then
    touch ${INSTALLED}

    # Add PHP 7.0 PPA
    add-apt-repository -y ppa:ondrej/php

    apt-get update
    apt-get remove php5-common -y

    # install general tools
    apt-get -y install ${PACKAGES}


    # download composer
     curl -sS https://getcomposer.org/installer | php
     mv composer.phar /usr/local/bin/composer

    # install Docker
    curl -sSL https://get.docker.com/ | sudo sh

    # add 'vagrant' user to docker group
    sudo usermod -aG docker vagrant

    # install Docker Compose
    curl -L "https://github.com/docker/compose/releases/download/${COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose
fi

# set time zone
echo ${TIMEZONE} | tee /etc/timezone
# changing NTP Time Servers
echo "server ${NTPPOOLZONE}" >> /etc/ntp.conf
