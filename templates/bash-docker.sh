#!/bin/bash

docker run -d --name postgres-sql \
  -e POSTGRES_USER=postgres       \
  -e POSTGRES_PASSWORD=4ebyrek    \
  -e POSTGRES_DB=gemstone         \
  -e POSTGRES_PORT=5432           \
  -p 5431:5432                    \
  --tmpfs /var/lib/postgresql/data:rw postgres:10
