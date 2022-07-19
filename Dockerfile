FROM ubuntu
MAINTAINER pushpkant
RUN apt-get update
RUN apt-get install tzdata
RUN apt-get install -y apache2 \
zip \
unzip
ADD https://www.free-css.com/assets/files/free-css-templates/download/page247/kindle.zip /var/www/html/
WORKDIR /var/www/html
RUN unzip kindle.zip
RUN cp -rvf markups-kindle/* .
RUN rm -rf _MACOS markups-kindle kindle.zip
CMD ["apachectl", "-D", "FOREGROUND"]
EXPOSE 3000
