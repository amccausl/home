#!/bin/bash

apt update
apt install net-tools

# haproxy
apt install libssl-dev
# make TARGET=generic USE_OPENSSL=1

# use uname to determine right package
apt install -y linux-headers-$(uname -r)
apt install -y expect

# System applications
apt install -y i3 i3lock i3status xclip
apt install -y pnmixer
apt install -y pasystray pavucontrol
apt install -y vim tofrodos gnotime pwgen
apt install -y roxterm rox-filer
apt install -y gimp feh vlc
apt install -y libreoffice libreoffice-gtk apvlv
apt install -y ia32-libs-gtk
apt install -y chromium

# TODO: update /etc/slim.conf
# set sessions, default_user, focus_password

# TODO: fstab changes per host

# Development application
apt install -y git git-gui git-cvs git-svn git-email gitk darcs mercurial subversion subversion-tools bzr bzrtools cvs thunar-vcs-plugin
apt install -y openssh-server
apt install -y apache2 memcached curl rsync cronolog mysql-client sqlite3 sqlitebrowser
# apt install -y mysql-server phpmyadmin
a2enmod proxy
a2enmod proxy_http
a2enmod rewrite
a2enmod ssl

# Mono
apt install -y mono-runtime

# PHP
apt install -y php5 php5-dev php-pear php5-gd php5-mysql php5-imagick php5-curl php5-xdebug php5-memcache

# Ruby
apt install ruby1.9.3 rake rubygems

# Haskell
apt install -y haskell-platform hxt-curl
cabal update
cabal install yesod-platform cabal-dev

apt install -y openjdk-6-jre icedtea6-plugin
apt install -y build-essential debhelper
apt install -y netbeans

apt install -y privoxy

echo "fs.inotify.max_user_watches=524288" >> /etc/sysctl.conf

