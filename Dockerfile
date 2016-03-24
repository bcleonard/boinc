FROM fedora:23
MAINTAINER Bradley Leonard <bradley@stygianresearch.com> 

# install boinc
RUN dnf -y install compat-libstdc++-296.i686 compat-libstdc++-33.i686 boinc-client\
  && dnf clean all

EXPOSE 80 443 31416

WORKDIR /var/lib/boinc

#USER boinc

# create directories
RUN mkdir /scripts

# add the startup.sh
ADD startup.sh /scripts/startup.sh
RUN chmod 755 /scripts/startup.sh

CMD ["/scripts/startup.sh"]
