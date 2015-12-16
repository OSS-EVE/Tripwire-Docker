#!/bin/bash
docker build -t tripwire-seed sql/
<<<<<<< HEAD
container=$(echo ${PWD##*/}| sed 's/-//')
docker run --rm --link ${container}_db_1:mysql tripwire-seed
=======
docker run --rm --link galileo-docker_db_1:mysql tripwire-seed
>>>>>>> a438aba026793fc7d3ba0f46ae53d3d28800dd52
