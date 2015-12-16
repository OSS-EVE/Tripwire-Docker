#!/bin/bash
docker build -t tripwire-seed sql/
container=$(echo ${PWD##*/}| sed 's/-//')
docker run --rm --link ${container}_db_1:mysql tripwire-seed
