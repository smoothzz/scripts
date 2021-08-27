#!/bin/bash

## Instalation of PHP7.4 on CENTOS8/Rocky/AlmaLinux

dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm -y
dnf install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y
dnf module list php -y
dnf module enable php:remi-7.4 -y
dnf install php php-fpm -y