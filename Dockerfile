FROM centos:7

MAINTAINER ybrdx <yohann.bredoux@gmail.com>

ARG http_proxy
ARG https_proxy

# Install sshd
# temporary fix since we have issue updating yum but it works anyway
RUN yum update | true && \
    yum -y install openssh-server

# add entrypoint script
ADD docker-entrypoint.sh /usr/sbin

#make sure we get fresh keys
RUN rm -rf /etc/ssh/ssh_host_rsa_key /etc/ssh/ssh_host_dsa_key

EXPOSE 22

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["/usr/sbin/sshd","-D"]