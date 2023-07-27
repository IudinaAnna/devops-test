# Task 
Optimize this unoptimized [Dockerfile](src/Dockerfile.unoptimized) to reduce building time and image size.

## Prerequisites
- Follow prerequisites steps 1-4 from [README.md](../../README.md)
- Navigate to the necessary folder
```
cd $HOME/training-devops-aiudina/docker/04-optimize-java-dockerfile/src
```

## How to run

1. [Build](https://docs.docker.com/engine/reference/commandline/build/) the image from an unoptimized [Dockerfile](src/Dockerfile.unoptimized)
```
docker build -f ./Dockerfile.unoptimized -t 04-hello-world-java-unoptimized:0.1 .
``` 

2. Run built image
```
docker run --name 04-unoptimized-java 04-hello-world-java-unoptimized:0.1
```
3. After, build an optimized [Dockerfile](src/Dockerfile.optimized)
```
docker build -f ./Dockerfile.optimized -t 04-hello-world-java-optimized:0.1 .
```

4. Run optimized container 
```
docker run --name 04-optimized-java 04-hello-world-java-optimized:0.1
```
5. Get the [list](https://docs.docker.com/engine/reference/commandline/images/) of all images in order to compare the two images
```
docker images
```
As result: 

- Unoptimized Dockerfile: 
  - image build time - `420 seconds`
  - image size - ` 692 MB` 
- Optimized Dockerfile: 
  - image build time - ` 25 seconds`
  - image size - `223 MB`

4. [Stop](https://docs.docker.com/engine/reference/commandline/stop/) the running container
```
docker stop 04-optimized-java 04-unoptimized-java
```
5. Remove the stopped container
```
docker rm 04-optimized-java 04-unoptimized-java
```
6. Remove images
```
docker rmi 04-hello-world-java-optimized:0.1 04-hello-world-java-unoptimized:0.1
```
7. Clean the system
```
docker system prune -f -a 
```

## References

 1. [Get Started with Docker](https://www.docker.com/get-started/)
 2. [Dockerfile](https://docs.docker.com/engine/reference/builder/#:~:text=A%20Dockerfile%20is%20a%20text,can%20use%20in%20a%20Dockerfile%20.)
 3. [Best practices for writing Dockerfiles](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/)
 4. [Multi-stage builds](https://docs.docker.com/build/building/multi-stage/)
 5. [Optimizing Docker Image Sizes](https://taylor.callsen.me/optimizing-docker-image-size/)
 5. [docker images](https://docs.docker.com/engine/reference/commandline/images/)
 6. [docker build](https://docs.docker.com/engine/reference/commandline/build/)
 7. [docker run](https://docs.docker.com/engine/reference/commandline/run/)
 8. [docker rm ](https://docs.docker.com/engine/reference/commandline/rm/)
