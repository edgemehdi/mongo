FROM edgemehdi/basic-pkgs 

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
RUN echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | tee /etc/apt/sources.list.d/10gen.list

#RUN dpkg-divert --local --rename --add /sbin/initctl
#RUN ln -s /bin/true /sbin/initctl

RUN apt-get update
RUN apt-get install -y mongodb-org


ADD mongodb.conf /etc/mongodb.conf

VOLUME ["/var/lib/mongodb"]

EXPOSE 27017

USER mongodb
WORKDIR /var/lib/mongodb

ENTRYPOINT ["/usr/bin/mongod", "--config", "/etc/mongodb.conf"]
CMD ["--quiet"]
