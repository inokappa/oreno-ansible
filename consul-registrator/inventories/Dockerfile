# MAINTAINER YOHEI KAWAHARA inokappa
FROM centos:centos6
RUN yum clean all
RUN yum install -y sudo openssh-server openssh-clients which curl
RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N ''
RUN ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key -N ''
#
RUN useradd -d /home/ansible -m -s /bin/bash ansible
RUN echo ansible:ansible | chpasswd
RUN echo 'ansible ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
#
CMD /usr/sbin/sshd -D -o UseDNS=no -o UsePAM=no -o PasswordAuthentication=yes -o UsePrivilegeSeparation=no -o PermitRootLogin=no -o PidFile=/tmp/sshd.pid
