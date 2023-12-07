#!/bin/bash

podman pod create -n node-app -p 3000:3000
podman run --detach --pod node-app -e MONGO_INITDB_ROOT_USERNAME=root -e MONGO_INITDB_ROOT_PASSWORD=postgres -e MONGO_INITDB_DATABASE=maindb --name mongodb mongo:4
podman run --detach --pod node-app -e MONGO_USERNAME=root -e MONGO_HOSTNAME="127.0.0.1" -e MONGO_PORT="27017" -e MONGO_DATABASE_NAME=maindb -e MONGO_PASSWORD=postgres --name mainapp filip3k/app-node-pod:latest

