#!/bin/bash
<<<<<<< HEAD
container=$(echo ${PWD##*/}| sed 's/-//')
docker run -it --link ${container}_db_1:mysql --rm mysql sh -c 'exec mysql -h"$MYSQL_PORT_3306_TCP_ADDR" -P"$MYSQL_PORT_3306_TCP_PORT" -uroot -p"$MYSQL_ENV_MYSQL_ROOT_PASSWORD"'
=======
docker run -it --link galileo-docker_db_1:mysql --rm mysql sh -c 'exec mysql -h"$MYSQL_PORT_3306_TCP_ADDR" -P"$MYSQL_PORT_3306_TCP_PORT" -uroot -p"$MYSQL_ENV_MYSQL_ROOT_PASSWORD"'
>>>>>>> a438aba026793fc7d3ba0f46ae53d3d28800dd52
