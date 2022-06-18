FROM ubuntu:20.04

RUN apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y ca-certificates gnupg systemctl libxml-libxslt-perl tini

RUN echo 'deb http://linux.dell.com/repo/community/openmanage/10200/focal focal main' > /etc/apt/sources.list.d/linux.dell.com.sources.list && \
  gpg --keyserver keyserver.ubuntu.com --recv-key 1285491434D8786F && \
  gpg -a --export 1285491434D8786F | apt-key add - && \
  apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y srvadmin-all || true

RUN rm /var/lib/dpkg/info/srvadmin-hapi.postinst && \
  touch /var/lib/dpkg/info/srvadmin-hapi.postinst && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y srvadmin-all || true

RUN rm /var/lib/dpkg/info/srvadmin-idracadm7.postinst && \
  touch /var/lib/dpkg/info/srvadmin-idracadm7.postinst && \
  rm /var/lib/dpkg/info/srvadmin-idracadm8.postinst && \
  touch /var/lib/dpkg/info/srvadmin-idracadm8.postinst && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y srvadmin-all || true

COPY docker-entrypoint.sh /

ENTRYPOINT ["tini", "/docker-entrypoint.sh"]
