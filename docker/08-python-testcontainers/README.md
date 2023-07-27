# Task
Run [redis](https://github.com/testcontainers/testcontainers-python/tree/94a63d611cd64dbeeaecebf0e9b4dc3ddaa22743/redis) example in testcontainers-python using [dockerize](https://blog.packagecloud.io/3-methods-to-run-docker-in-docker-containers/). Make test reports accessible to the host after the container stops.

## Prerequisites
- Follow prerequisites steps 1-5 from [README.md](../../README.md)
- Go to the folder with submodules
```
cd $HOME/training-devops-aiudina/submodules/testcontainers-python
```
- Copy `testcontainers-python` submodule to your working directory 
```
cp -r $HOME/training-devops-aiudina/submodules/testcontainers-python ~/training-devops-aiudina/docker/08-python-testcontainers/src
```
- Go to the necessary folder
```
cd ~/training-devops-aiudina/docker/08-python-testcontainers/src
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
3. Build [Dockerfile](src/Dockerfile)
```
docker build -f ./Dockerfile -t 08-python-testcontainers:0.1 .
```
If you want to replace values for `USER_ID` and `GROUP_ID` use the command below. Replace `<username>` with the name of the existing user
```
docker build -f ./Dockerfile --build-arg USER_ID=$(id -u) --build-arg GROUP_ID=$(id -g) -t 08-python-testcontainers:0.1 .
```

4. For reports create a new folder `/report` 
```
mkdir $HOME/training-devops-aiudina/docker/08-python-testcontainers/report
```
5. Run 08-python-testcontainers:0.1 image
```
docker run --name testcontainer-python --rm --mount type=bind,source=$HOME/training-devops-aiudina/docker/08-python-testcontainers/report,destination=/app/report --network demo-network 08-python-testcontainers:0.1
```
6. To check reports go to the reports folder  and do `ls -lha` command. 
```
cd ~/training-devops-aiudina/docker/08-python-testcontainers/report/python
```
To check report in the browser do `pwd` command, copy path and paste this path into the search field of your browser. You should see the page with the test summary. 

7. After all steps clear your reports and images
- delete report folder
```
rm -r ~/training-devops-aiudina/docker/08-python-testcontainers/report
```
- delete image
```
docker rmi 08-python-testcontainers:0.1
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

