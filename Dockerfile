FROM ubuntu:trusty
MAINTAINER Parintorn Sukhowatnakit <parintorns@gmail.com>

# Install base packages
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive \
    apt-get -yq install \
    curl \
    apache2 \
    libapache2-mod-php5 \
    php5-mcrypt \
    php5-gd \
    php5-curl \
    php-pear \
    php-apc && \
    rm -rf /var/lib/apt/lists/*
RUN /usr/sbin/php5enmod mcrypt
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf && \
    sed -i "s/variables_order.*/variables_order = \"EGPCS\"/g" /etc/php5/apache2/php.ini

# Add scripts
ADD run.sh /run.sh
RUN chmod 755 /*.sh

# Configure /app folder
RUN mkdir -p /app && rm -fr /var/www/html && ln -s /app /var/www/html

EXPOSE 80
WORKDIR /app
CMD ["/run.sh"]
