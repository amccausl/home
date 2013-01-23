#!/bin/bash

apt-get update
aptitude -y safe-upgrade

# use uname to determine right package
aptitude install -y linux-headers-$(uname -r)
aptitude install -y expect

# System applications
aptitude install -y i3 i3lock i3status xclip
aptitude install -y vim tofrodos gnotime
aptitude install -y roxterm rox-filer
aptitude install -y feh vlc xmms2 xmms2-plugin-flac promoe
aptitude install -y libreoffice libreoffice-gtk apvlv
aptitude install -y ia32-libs-gtk
aptitude install -y chromium
dpkg -i skype-debian_4.0.0.8-1_amd64.deb

# TODO: update /etc/slim.conf
# set sessions, default_user, focus_password

# TODO: fstab changes per host

# Development application
aptitude install -y git git-gui git-cvs git-svn git-email gitk darcs mercurial subversion subversion-tools bzr bzrtools cvs thunar-vcs-plugin
aptitude install -y openssh-server
aptitude install -y apache2 memcached curl rsync cronolog mysql-client
# aptitude install -y mysql-server phpmyadmin
a2enmod proxy
a2enmod proxy_http
a2enmod rewrite
a2enmod ssl

echo "10.10.10.90     hydra" >> /etc/hosts
echo "127.0.0.1       dev.teambuy.ca" >> /etc/hosts

# Mono
aptitude install -y mono-runtime

# PHP
aptitude install -y php5 php5-dev php-pear php5-gd php5-mysql php5-imagick php5-curl php5-xdebug php5-memcache

# Ruby
aptitude install ruby1.9.3 rake rubygems

# Haskell
aptitude install -y haskell-platform hxt-curl
cabal update
cabal install yesod-platform cabal-dev

aptitude install -y openjdk-6-jre icedtea6-plugin
aptitude install -y build-essential debhelper
aptitude install -y netbeans

aptitude install -y privoxy

# teambuy
mkdir /var/teambuy
mkdir /var/teambuy/v2-log
mkdir /var/teambuy/v2-log/server
mkdir /var/teambuy/v2-log/perf
mkdir /var/teambuy/v2-log/request
cp -r /var/teambuy/v2-log /var/teambuy/v1-log
chown -R www-data /var/teambuy
