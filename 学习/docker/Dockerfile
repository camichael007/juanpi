# 选择一个已有的centos镜像作为基础
FROM ubuntu:15.10
# 镜像的作者
MAINTAINER Linc "13579443@qq.com"
RUN TERM=linux && export TERM
RUN  apt-get  update
# 安装openssh-server,sudo,crontab,lrzsz以及常用网络命令和编译依赖库，并且将sshd的UsePAM参数设置成no
RUN  apt-get install -y openssh-server  vim net-tools telnet ntp lrzsz unzip     gcc  g++  make     python  
 #修改root密码
RUN echo "root:root888" | chpasswd 
# 添加测试用户admin，密码admin，并且将此用户添加到sudoers里
RUN useradd admin && mkdir -p /home/admin && echo "admin:admin888" | chpasswd && echo "admin   ALL=(ALL)       ALL" >> /etc/sudoers 
#安装Monit
RUN mkdir -p /data
WORKDIR /data 
ADD monit_install.zip /data/
RUN unzip monit_install.zip && cd monit_install && chmod 777 monit_install.sh && ./monit_install.sh && rm -rf  /data/monit_install*
# 暴露sshd服务22端口和Monit服务8081端口
EXPOSE 22 8081 
# 启动Monit,Monit启动其他服务进程
CMD monit  