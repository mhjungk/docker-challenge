# docker-challenge
All cases are tested in Suse Linux 13.2 on VMware with Docker Engine 1.11.1, Docker Swarm 1.2.3, Vagrant 1.8.1.

## Challenge 1 (/c1)
After installing Docker in Suse, 'Dockerfile' including an error was created in c1 directory. And the error message below was found when compiling the script by '$ docker build .'.

![alt tag](https://github.com/mhjungk/docker-challenge/blob/master/c1/screenshot-1.png)

RUN instruction executes the command. But, 'boom' is not a valid command. So, it failed to run command and we can check it from error messages.

## Challenge 2 (/c1)
In this case, the test environment is automatically established using Vagrant. By the 'Vagraintfile', two Docker images of Wordpress and MySQL are downloaded and started. '--no-parallel' option should be added when setting up like 'vagrant up --no-parallel' because the MySQL container should be created before Wordpress.<br />
After that, orchestration and clustering are necessary for containers. I choose Docker swarm for it because it is one of the sub projects in Docker and thus, it would be working well with Docker. The script 'cluster.sh' will generate Consul and manager containers. It should be executed as super user with 'sudo'. Consul container acts as a discovery back and which means that it is used for managers and nodes to authenticate and find available nodes. To make Docker Engine more available, more managers can be added. Two containers are clustered with Consul and manager helps to check status.<br />
Unfortunately, it was tested in a single host, the status of clusters could not be checked because Docker daemon is not running in the container.
