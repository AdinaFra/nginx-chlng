FROM centos:7
MAINTAINER Adina
RUN yum install -y gcc gcc-c++  pcre pcre-devel pcre2 pcre2-devel openssl-devel autoconf make autoconf automake git ruby ruby-devel curl libyaml-devel rpm-build wget
RUN wget https://nginx.org/download/nginx-1.15.7.tar.gz && tar zxf nginx-1.15.7.tar.gz
RUN wget ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.42.tar.gz && tar -zxf pcre-8.42.tar.gz && cd pcre-8.42 && ./configure && make && make install
RUN wget http://zlib.net/zlib-1.2.11.tar.gz && tar -zxf zlib-1.2.11.tar.gz && cd zlib-1.2.11 && ./configure && make && make install
WORKDIR nginx-1.15.7
RUN ./configure --sbin-path=/usr/local/nginx/nginx --conf-path=/usr/local/nginx/nginx.conf --pid-path=/usr/local/nginx/nginx.pid --with-pcre=../pcre-8.42 --with-zlib=../zlib-1.2.11 --with-http_ssl_module --with-stream --with-mail=dynamic
RUN make && make install
RUN sed -i -e "s/80/8080/g" /usr/local/nginx/nginx.conf
RUN sed -i -e "s/nginx/mynginx/g" /usr/local/nginx/html/index.html
RUN mkdir /usr/websites && cp /usr/local/nginx/html/index.html /usr/websites/ && sed -i -e "s|html;|\/usr/websites;|1" /usr/local/nginx/nginx.conf
EXPOSE 8080 80
CMD ["/usr/local/nginx/nginx", "-g", "daemon off;"]

