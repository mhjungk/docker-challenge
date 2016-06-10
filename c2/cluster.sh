#!/bin/bash
# Start Consul container as a discovery backend
docker run -d -p 8500:8500 --name=consul progrium/consul -server -bootstrap

# Find ip address of containers
ip_consul="$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' consul)"
ip_mysql="$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' mj-mysql)"
ip_wp="$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' mj-wordpress)"

# Start a docker manager
docker run -d -p 4000:4000 swarm manage -H :4000 --replication --advertise :4000 consul://$ip_consul:8500

# Clustering two containers
docker run -d swarm join --advertise=$ip_mysql:2375 consul://$ip_consul:8500
docker run -d swarm join --advertise=$ip_wp:2375 consul://$ip_consul:8500
