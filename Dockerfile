# Base Image
FROM amazonlinux:2017.09

# Maintainer
LABEL maintainer="devops@processmaker.com"

LABEL processmaker-stack="pm4"

# Install processmaker 
COPY ["script-config/installpm.sh", "/tmp/"]
COPY ["script-config/gai.conf", "/etc/"]
COPY ["script-config/php-fpm-7.2", "/etc/rc.d/init.d/"]
RUN  chmod 700 /tmp/installpm.sh && \
     chmod 755 /etc/rc.d/init.d/php-fpm-7.2 \
     chmod 644 /etc/gai.conf \ 
     /bin/sh /tmp/installpm.sh      
COPY ["file-config/php-fpm.conf", "/etc/php-fpm.d/processmaker.conf"]
COPY ["file-config/nginx.conf", "/etc/nginx/nginx.conf"]
COPY ["file-config/processmaker.conf", "/etc/nginx/conf.d/processmaker.conf"]
COPY ["file-config/processmaker-horizon.conf", "/etc/supervisor/processmaker-horizon.conf"]
COPY ["file-config/processmaker-echo-server.conf", "/etc/supervisor/processmaker-echo-server.conf"]

# Docker entrypoint
EXPOSE 80 6001