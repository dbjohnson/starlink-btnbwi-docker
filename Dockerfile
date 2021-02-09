FROM php:7.2.1-apache

# install grpcurl
WORKDIR /usr/local/bin
RUN cd /usr/local/bin && curl -L https://github.com/fullstorydev/grpcurl/releases/download/v1.8.0/grpcurl_1.8.0_linux_x86_64.tar.gz | tar xzv

# install git, speedtest
RUN apt-get update -y && apt-get install -y git speedtest-cli 

# clone repo
WORKDIR /var/www/html
RUN git clone https://github.com/ChuckTSI/BetterThanNothingWebInterface.git
RUN ln -s /var/www/html/BetterThanNothingWebInterface/* /var/www/html

# schedule speedtest
RUN mkdir /etc/cron.d
RUN echo "*/5 * * * * php /var/www/html/BetterThanNothingWebInterface/scripts/cron/php/speedtest.cron.php" > /etc/cron.d/btnwi

# start apache and run update script
CMD /etc/init.d/apache2 start && /var/www/html/BetterThanNothingWebInterface/scripts/binbash/starlink.update.sh
