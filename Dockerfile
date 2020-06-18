FROM ubuntu:18.04

LABEL maintainer="Rick Rackow rrackow@redhat.com"

# Generic settings
ENV DEBIAN_FRONTEND noninteractive
ENV INITRD No
ENV LANG en_US.UTF-8

# SnapD tuning
ENV container docker
ENV PATH /snap/bin:$PATH

# Install tooling
RUN apt-get update &&\
      apt-get install -y wget \ 
      git \
      findutils \
      gnupg2

# Golang Settings
ENV GOVERSION 1.14.4
ENV GOROOT /opt/go
ENV GOPATH /root/.go

# Install Golang
RUN cd /opt && wget https://storage.googleapis.com/golang/go${GOVERSION}.linux-amd64.tar.gz && \
    tar zxf go${GOVERSION}.linux-amd64.tar.gz && rm go${GOVERSION}.linux-amd64.tar.gz && \
    ln -s /opt/go/bin/go /usr/bin/ && \
    mkdir $GOPATH

# Install BBHT tools using install script
COPY install.sh .
RUN chmod +x install.sh &&\
      ./install.sh
