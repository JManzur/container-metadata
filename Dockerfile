FROM httpd:latest

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install curl jq -y

ADD index.html /usr/local/apache2/htdocs/
ADD bootstrap.sh /bootstrap.sh

RUN chmod +x /bootstrap.sh
RUN sed -i 's/Listen 80/Listen 8888/' /usr/local/apache2/conf/httpd.conf

EXPOSE 8888

CMD ["/bootstrap.sh"]