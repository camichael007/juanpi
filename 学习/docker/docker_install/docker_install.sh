#!/bin/bash -e
#创建Tengine用户以及用户组
tmp=`cat /etc/group | awk -F: '/^docker/{print $1}'`
if [ -z "$tmp" ]; then
   groupadd docker
fi

tmp=`cat /etc/passwd | awk -F: '/^docker/{print $1}'`
if [ -z "$tmp" ]; then
   useradd -M -s /sbin/nologin -r -g docker docker
fi
tar xzvf docker-*.tgz -C /usr/local 
ln -fs /usr/local/docker/*  /usr/bin/
#yum update -y kernel
#yum install -y  net-tools telnet  crontabs  lrzsz unzip vim   gcc cpp gcc-c++  make     python python-devel  
yum install  -y kernel-devel kernel-headers  bridge-utils iptables  git procps 
echo 1 > /proc/sys/net/ipv4/ip_forward
mkdir -p /data/docker 
cp ./dockerctl  /usr/bin/dockerctl
chmod +x /usr/bin/dockerctl
dockerctl start
sed -i 's/^exit 0$/#exit 0/'  /etc/rc.local 
echo '/usr/bin/dockerctl start' >> /etc/rc.local
chmod +x /etc/rc.local