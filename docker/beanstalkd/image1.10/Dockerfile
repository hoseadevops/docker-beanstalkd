FROM phusion/baseimage:latest

MAINTAINER hosea <hoseadevops@gmail.com>

ENV PATH /usr/local/rvm/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# install curl (needed to install rust)
RUN DEBIAN_FRONTEND=noninteractive apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y curl build-essential
# download
RUN curl -sL https://github.com/kr/beanstalkd/archive/v1.10.tar.gz | tar xvz -C /tmp
# build and install
RUN cd /tmp/beanstalkd-1.10; make; cp beanstalkd /usr/bin
# clean
RUN DEBIAN_FRONTEND=noninteractive apt-get remove --purge -y curl build-essential && DEBIAN_FRONTEND=noninteractive apt-get autoclean && DEBIAN_FRONTEND=noninteractive apt-get clean

RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*