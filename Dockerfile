FROM centos:latest

RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == \
systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;
VOLUME [ "/sys/fs/cgroup" ]
CMD ["/usr/sbin/init"]

RUN yum -y update && yum clean all

RUN yum -y install git wget nano net-tools gcc gcc-c++ libaio-devel

RUN yum -y groupinstall "Development Tools"

RUN yum -y install epel-release

RUN yum -y install nodejs

RUN node -v

RUN npm -v

#get oracle drivers
RUN wget http://ftp.riken.jp/Linux/cern/centos/7/cernonly/x86_64/Packages/oracle-instantclient12.1-basic-12.1.0.2.0-1.x86_64.rpm \
    && rpm -ivh oracle-instantclient12.1-basic-12.1.0.2.0-1.x86_64.rpm \
    && rm oracle-instantclient12.1-basic-12.1.0.2.0-1.x86_64.rpm

RUN wget http://ftp.riken.jp/Linux/cern/centos/7/cernonly/x86_64/Packages/oracle-instantclient12.1-devel-12.1.0.2.0-1.x86_64.rpm \
    && rpm -ivh oracle-instantclient12.1-devel-12.1.0.2.0-1.x86_64.rpm \
    && rm oracle-instantclient12.1-devel-12.1.0.2.0-1.x86_64.rpm

EXPOSE 8080
EXPOSE 1337
