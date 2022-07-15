#!/bin/bash

echo "Creating ToDoList Database"

# Re-create DB container
docker kill todo_list_db
docker rm todo_list_db
docker run --name todo_list_db -e POSTGRES_PASSWORD=docker -p 5432:5432 -d postgres
sleep 2

# Populate the DB
PGPASSWORD="docker" psql -h "localhost" -d "postgres" -U "postgres" -f lib/repo/db.sql

