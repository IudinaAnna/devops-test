
# Task
In this task let's run two containers: `nginxdemos/hello` inside [dind](https://itnext.io/docker-in-docker-521958d34efd) and in local docker. Explain how we can run containers inside dind using context.

# Prerequisites 

1. Follow prerequisites steps 1-4 from [README.md](../../README.md)
2. Go to the folder with the cloning project:
```
cd $HOME/training-devops-aiudina/docker/05-run-nginx-inside-dind-and-in-local-docker
```

# How to run 

1. Create network
```
docker network create demo-network
```
2. Run dind container
```
docker run --privileged -d -p 12377:2375 -p 5050:5050 --name dind -e DOCKER_TLS_CERTDIR="" --network demo-network docker:23.0.1-dind
```
3. Run `nginxdemos/hello` inside `dind`using `context`. 
```
docker -H localhost:12377 run -d --name 05-nginx-inside-dind -p 5050:80 nginxdemos/hello
```

To check if we can connect to our nginx inside dind, using command:
```
curl localhost:5050
```
and after
```
docker -H localhost:12377 ps -a
```

4. Now run `nginxdemos/hello` in local docker

```
docker run -d --name 05-nginx-in-local-docker -p 7050:80 nginxdemos/hello 
```
To check if we can connect to our nginx in local docker, using command:
```
curl localhost:7050
```

5. Stop and delete the running container in local docker
```
docker stop 05-nginx-in-local-docker 
```
```
docker rm 05-nginx-in-local-docker 
```
```
docker rmi nginxdemos/hello 
```
6. Delete the running container inside dind
```
docker -H localhost:12377 rm -f 05-nginx-inside-dind
```
```
docker -H localhost:12377 rmi nginxdemos/hello
```
7. Clean the system
```
docker system prune -f -a 
```
# References
1. [Execute Python script](https://pythonbasics.org/execute-python-scripts/)
2. [Python Examples](https://docs.python.org/3/library/argparse.html)
3. [Dockerfile reference](https://docs.docker.com/engine/reference/builder/)
4. [CMD VS ENTRYPOINT](https://www.bmc.com/blogs/docker-cmd-vs-entrypoint/)
5. [Docker build](https://docs.docker.com/engine/reference/commandline/build/)
6. [Docker images](https://docs.docker.com/engine/reference/commandline/images/)
7. [Docker run](https://docs.docker.com/engine/reference/commandline/run/)
8. [Docker Hub image library](https://hub.docker.com/)
9. [Docker rm ](https://docs.docker.com/engine/reference/commandline/rm/)
10. [Docker in docker](https://itnext.io/docker-in-docker-521958d34efd)


