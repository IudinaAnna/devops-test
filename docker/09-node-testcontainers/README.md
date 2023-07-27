# Task
Run [postgresql](https://github.com/testcontainers/testcontainers-node/tree/69f6755f13e87c044af3a2f4b77d05d71fce2bb9/src/modules/postgresql) example in testcontainers-node using [dockerize](https://blog.packagecloud.io/3-methods-to-run-docker-in-docker-containers/). Make test reports accessible to the host after the container stops.

## Prerequisites
- Follow prerequisites steps 1-5 from [README.md](../../README.md)
- Go to the necessary folder
```
cd $HOME/training-devops-aiudina/submodules/testcontainers-node
```
- Copy [testcontainers-node](../../submodules/testcontainers-node) submodule to your working directory 
```
cp -r $HOME/training-devops-aiudina/submodules/testcontainers-node ~/training-devops-aiudina/docker/09-node-testcontainers/src

```
- Go to the necessary folder
```
cd ~/training-devops-aiudina/docker/09-node-testcontainers/src

```


## How to run
Before build image, set the default values of `USER_ID` and `GROUP_ID` in [Dockerfile](src/Dockerfile). Use the commands bellow to set values to your personal user and group id
```
sed -i "s/ARG USER_ID=1000/ARG USER_ID=$(id -u)/" Dockerfile
```
```
sed -i "s/ARG GROUP_ID=1000/ARG GROUP_ID=$(id -g)/" Dockerfile
```

1. Create [network](https://docs.docker.com/engine/reference/commandline/network_create/)
```
docker network create demo-network
```
2. Run [dind](https://shisho.dev/blog/posts/docker-in-docker/) container
```
docker run --privileged -d -p 12380:2375 --name dind -e DOCKER_TLS_CERTDIR="" --network demo-network docker:23.0.1-dind
```
3. Build [Dockerfile](src/Dockerfile)
```
docker build -f ./Dockerfile -t 09-node-testcontainers:0.1 .
```
If you want to replace values for `USER_ID` and `GROUP_ID`  use the command below. Replace `<username>` with the name of the existing user
```
docker build -f ./Dockerfile --build-arg USER_ID=$(id <username> -u) --build-arg GROUP_ID=$(id <username> -g) -t 09-node-testcontainers:0.1 .
```
4. For reports create a new folder `/report` 
```
mkdir $HOME/training-devops-aiudina/docker/09-node-testcontainers/report
```
5. Run 09-node-testcontainers:0.1 image
```
docker run --name testcontainer-node --rm --mount type=bind,source=$HOME/training-devops-aiudina/docker/09-node-testcontainers/report,destination=/app/report --network demo-network 09-node-testcontainers:0.1
```
6. To check reports go to the `report` folder  and do `ls -lha` command. 
```
cd ~/training-devops-aiudina/docker/09-node-testcontainers/report/node
```
7. To view report in the browser do `pwd` command, after copy path and paste it into the search field of your browser. At the end of path add `/index.html` <br>
You should see the page with test summary. 

8. After all steps clear system

- delete image
```
docker rmi 09-node-testcontainers:0.1
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
 4. [Testcontainers](https://testcontainers.org/)
 5. [Best practices for writing Dockerfiles](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/)
 6. [docker images](https://docs.docker.com/engine/reference/commandline/images/)
 7. [docker build](https://docs.docker.com/engine/reference/commandline/build/)
 8. [docker run](https://docs.docker.com/engine/reference/commandline/run/)
 9. [docker network](https://docs.docker.com/engine/reference/commandline/network_create/)
 10. [Sed command](https://www.gnu.org/software/sed/manual/sed.html#sed-script-overview)

