from php:fpm

maintainer Alexander Schittler <me@damongant.de> (Send ISK to Enta Ozuwara)

run apt-get update
run apt-get install -y cron
add crontab /etc/cron.d/tripwire
run chmod 644 /etc/cron.d/tripwire
run touch /var/log/cron.log

cmd cron && tail -f /var/log/cron.log
