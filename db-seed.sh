#!/bin/bash
docker build -t tripwire-seed sql/
docker run --rm --link tripwire_db_1:mysql tripwire-seed
