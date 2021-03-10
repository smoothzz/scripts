echo " Instalador Nagios "

sleep 1

echo " Baixando Pacotes "

sleep 1
yum install wget httpd php gcc glibc glibc-common gd gd-devel -y

echo "Criando Usuario e grupo "
sleep 1

/usr/sbin/useradd -m nagios

passwd nagios

sleep 1 

/usr/sbin/groupadd nagcmd

/usr/sbin/usermod -a -G nagcmd nagios

/usr/sbin/usermod -a -G nagcmd apache

sleep 1

echo "Download Nagios e Plugin"

sleep 1

mkdir /softwares
cd /softwares

wget http://prdownloads.sourceforge.net/sourceforge/nagios/nagios-3.2.3.tar.gz
sleep 1 
wget http://prdownloads.sourceforge.net/sourceforge/nagiosplug/nagios-plugins-1.4.11.tar.gz

echo " Extraindo , compilando e instalando "

sleep 1

tar xzf nagios-3.2.3.tar.gz

cd nagios-3.2.3

./configure --with-command-group=nagcmd

make all

make install

make install-init

make install-config

make install-commandmode

make install-webconf

htpasswd -c /usr/local/nagios/etc/htpasswd.users nagiosadmin

service httpd restart

cd ..

tar xzf nagios-plugins-1.4.11.tar.gz

cd nagios-plugins-1.4.11

./configure --with-nagios-user=nagios --with-nagios-group=nagios

make

make install

chkconfig --add nagios

chkconfig nagios on

service nagios start