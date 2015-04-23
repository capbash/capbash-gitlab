# Data: docker run --name gitlab_data genezys/gitlab:7.5.2 /bin/true
# Run:  docker run --detach --name gitlab --publish 8080:80 --publish 2222:22 --volumes-from gitlab_data genezys/gitlab:7.5.2
FROM ubuntu:14.04
MAINTAINER Andrew Forard <aforward@gmail.com>

RUN apt-get update -q && \
  DEBIAN_FRONTEND=noninteractive apt-get install -qy openssh-server wget && \
  apt-get clean

RUN TMP_FILE=$(mktemp) && \
  wget -q -O $TMP_FILE https://downloads-packages.s3.amazonaws.com/ubuntu-14.04/gitlab_@GITLAB_VERSION@-omnibus.1-1_amd64.deb && \
  dpkg -i $TMP_FILE && \
  rm -f $TMP_FILE

RUN mkdir -p /opt/gitlab/sv/sshd/supervise && \
  mkfifo /opt/gitlab/sv/sshd/supervise/ok && \
  printf "#!/bin/sh\nexec 2>&1\numask 077\nexec /usr/sbin/sshd -D" > /opt/gitlab/sv/sshd/run && \
  chmod a+x /opt/gitlab/sv/sshd/run && \
  ln -s /opt/gitlab/sv/sshd /opt/gitlab/service && \
  mkdir -p /var/run/sshd

EXPOSE 80 22
ENV "GITLAB_SERVER_URL=@GITLAB_SERVER_URL@"
ENV "GITLAB_CI_URL=@GITLAB_CI_URL@"

VOLUME ["/var/opt/gitlab", "/var/log/gitlab", "/etc/gitlab"]

ENV PATH /usr/local/dockerbin:$PATH
ADD bin /usr/local/dockerbin
ADD src/gitlab.rb /etc/gitlab/

