#!/bin/zsh

containers="$(podman container ls -aq -f"name=flask")"

for container in $containers
do
    podman container stop $container
    podman container rm $container
done

podman image rm $(podman image ls -f"dangling=true" -q)

podman image build --no-cache -t flask:latest -f flask_linux .
podman container run -p 127.0.0.1:8080:8080 -d --name flask flask:latest 

podman container ls -a | grep flask

sleep 1

podman container ls -a

# container=$(podman container ls -a | grep flask | awk '{print $1}')
# podman container run -it flask:latest /bin/sh