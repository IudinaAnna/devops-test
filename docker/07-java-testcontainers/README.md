# Task
Run [redis-backed-cache-testng](https://github.com/testcontainers/testcontainers-java/tree/main/examples/redis-backed-cache-testng) example in testcontainers-java using [dockerize](https://blog.packagecloud.io/3-methods-to-run-docker-in-docker-containers/). Make test reports accessible to the host after the container stops.

## Prerequisites
- Follow prerequisites steps 1-5 from [README.md](../../README.md)
- Go to the folder with submodules
```
cd $HOME/training-devops-aiudina/submodules/testcontainers-java
```
- Copy `testcontainers-java` submodule to your working directory 
```
cp -r $HOME/training-devops-aiudina/submodules/testcontainers-java ~/training-devops-aiudina/docker/07-java-testcontainers/src
```
- Go to the necessary folder
```
cd ~/training-devops-aiudina/docker/07-java-testcontainers/src
```


## How to run
1. Create [network](https://docs.docker.com/engine/reference/commandline/network_create/)
```
docker network create demo-network
```
2. Run [dind](https://shisho.dev/blog/posts/docker-in-docker/) container
```
docker run --privileged -d -p 12380:2375 --name dind -e DOCKER_TLS_CERTDIR="" --network demo-network docker:23.0.1-dind
```
Before build image, set the default values of `USER_ID` and `GROUP_ID` in [Dokcerfile](src/Dockerfile). Use the commands below to set values to your personal user and group id.
```
sed -i "s/ARG USER_ID=1000/ARG USER_ID=$(id -u)/" Dockerfile
```
```
sed -i "s/ARG GROUP_ID=1000/ARG GROUP_ID=$(id -g)/" Dockerfile
```
3. Build [Dockerfile](src/Dockerfile)
```
docker build -f ./Dockerfile -t 07-java-testcontainers:0.1 .
```
If you want to replace values for `USER_ID` and `GROUP_ID` use the commands below. Replace `<username>` with the name of the existing user.
```
docker build -f ./Dockerfile --build-arg USER_ID=$(id <username> -u) --build-arg GROUP_ID=$(id <username> -g) -t 07-java-testcontainers:0.1 .
```

4. For reports create a new folder `/report` 
```
mkdir $HOME/training-devops-aiudina/docker/07-java-testcontainers/report
```
5. Run 07-java-testcontainers:0.1 image
```
docker run --name testcontainer-java --rm --mount type=bind,source=$HOME/training-devops-aiudina/docker/07-java-testcontainers/report,destination=/app/examples/redis-backed-cache-testng/build --network demo-network 07-java-testcontainers:0.1
```
6. To check reports go to the reports folder  and do `ls -lha` command. 
```
cd ~/training-devops-aiudina/docker/07-java-testcontainers/report
```
To check reports in browser do `pwd` command, copy the path and paste this path into the search field of your browser. You should see the page with test summary. 

7. After all steps clear the system
- delete image
```
docker rmi 07-java-testcontainers:0.1
```
- delete dind container
```
docker rm -f dind
```
- clear your vm
```
docker system prune -f -a
```
## References

 1. [Get Started with Docker](https://www.docker.com/get-started/)
 2. [Dind](https://shisho.dev/blog/posts/docker-in-docker/)
 3. [Dockerfile](https://docs.docker.com/engine/reference/builder/#:~:text=A%20Dockerfile%20is%20a%20text,can%20use%20in%20a%20Dockerfile%20.)
 4. [Best practices for writing Dockerfiles](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/)
 5. [docker images](https://docs.docker.com/engine/reference/commandline/images/)
 6. [docker build](https://docs.docker.com/engine/reference/commandline/build/)
 7. [docker run](https://docs.docker.com/engine/reference/commandline/run/)
 8. [docker network](https://docs.docker.com/engine/reference/commandline/network_create/)

