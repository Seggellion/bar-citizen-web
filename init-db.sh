#!/bin/bash
set -e

# Assumes POSTGRES_USER, POSTGRES_PASSWORD, and POSTGRES_DB are set in your environment
# These variables should be the same ones you use in your docker-compose.yml

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
    CREATE USER "$POSTGRES_USER" WITH PASSWORD '$POSTGRES_PASSWORD';
    CREATE DATABASE "$POSTGRES_DB";
    GRANT ALL PRIVILEGES ON DATABASE "$POSTGRES_DB" TO "$POSTGRES_USER";
EOSQL
