#!/bin/bash -e
tar  xzvf monit-*.tar.gz
cd  monit-*
./configure  --prefix=/usr/local/monit  --enable-optimized --enable-profiling --without-pam  --without-ssl
make && make install
mkdir -p /usr/local/monit/etc/ 
cd ..
cp -rf monitrc /usr/local/monit/etc
chmod 700 -R /usr/local/monit/etc
ln -fs /usr/local/monit/bin/monit /usr/sbin/

#开机自动启动
echo '/usr/sbin/monit' >> /etc/rc.d/rc.local 
monit
