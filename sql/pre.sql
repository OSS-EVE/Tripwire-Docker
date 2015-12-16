create database if not exists tripwire;
grant all on tripwire.* to 'tripwire'@'%' identified by "weaknesspays";

create database if not exists eve_api;
grant all on eve_api.* to 'tripwire'@'%' identified by "weaknesspays";
