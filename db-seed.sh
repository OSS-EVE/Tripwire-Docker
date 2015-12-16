#!/bin/bash
docker build -t tripwire-seed sql/
docker run --rm --link galileo-docker_db_1:mysql tripwire-seed
