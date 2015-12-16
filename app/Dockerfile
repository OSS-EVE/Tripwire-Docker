from php:fpm

maintainer Alexander Schittler <me@damongant.de> (Send ISK to Enta Ozuwara)

run apt-get update
run apt-get install -y git
run git clone https://bitbucket.org/daimian/tripwire /var/www/html/

run docker-php-ext-install pdo pdo_mysql

add php.ini /usr/local/etc/php-fpm.conf
add info.php /var/www/html/
add db.inc.php /var/www/html/

expose 9000
volume /var/www/html
