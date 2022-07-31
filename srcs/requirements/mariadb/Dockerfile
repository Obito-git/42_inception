FROM		alpine:3.14

RUN apk update
RUN apk upgrade

RUN apk add openrc mariadb mariadb-common mariadb-client mariadb-server-utils

COPY conf/default.conf /etc/mysql/my.cnf
COPY conf/default.conf /etc/my.cnf
COPY conf/default.conf ~/my.cnf

RUN mkdir -p /run/mysqld
RUN mkdir -p /var/lib/mysql
RUN chown -R mysql /var/lib/mysql
RUN chmod 777 /var/lib/mysql

COPY conf/setup-db.sh setup-db.sh
RUN chmod +x setup-db.sh

EXPOSE		3306

CMD ["sh", "setup-db.sh"]

