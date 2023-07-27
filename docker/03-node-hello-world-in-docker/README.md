# Task 
Let's create a simple Node program that prints "Hello World !!!" in the console and  a Dockerfile that will provide commands for executing the program.

## Prerequisites

1. Follow prerequisites steps 1-4 from [README.md](../../README.md)
2. Navigate to the necessary folder
```
cd $HOME/training-devops-aiudina/docker/03-node-hello-world-in-docker/src
```

## How to run


1. [Build](https://docs.docker.com/engine/reference/commandline/build/) our image
```
docker build -f ./Dockerfile -t 03-node-hello-world-in-docker:0.1 .
``` 

2. Get the list of [images](https://docs.docker.com/engine/reference/commandline/images/) to check if 03-node-hello-world-in-docker:0.1 was created
```
docker images
```
3. [Run](https://docs.docker.com/engine/reference/commandline/run/) the container
```
docker run --name 03-task 03-node-hello-world-in-docker:0.1
```
The output: "Hello World !!!" 

4. [Stop](https://docs.docker.com/engine/reference/commandline/stop/) the running container
```
docker stop 03-task
```
5. Remove the stopped container
```
docker rm 03-task
```
6. Remove the image
```
docker rmi 03-node-hello-world-in-docker:0.1
```
6. Clean the system
```
docker system prune -f -a 
```


## References

 1. [Introduction to Node.js](https://nodejs.dev/en/learn/)
 2. [Dockerfile](https://docs.docker.com/engine/reference/builder/#:~:text=A%20Dockerfile%20is%20a%20text,can%20use%20in%20a%20Dockerfile%20.)
 3. [Docker Hub Image Library](https://hub.docker.com/)
 4. [docker images](https://docs.docker.com/engine/reference/commandline/images/)
 5. [docker build](https://docs.docker.com/engine/reference/commandline/build/)
 6. [docker run](https://docs.docker.com/engine/reference/commandline/run/)
 7. [CMD VS ENTRYPOINT](https://www.bmc.com/blogs/docker-cmd-vs-entrypoint/)
 8. [Docker rm ](https://docs.docker.com/engine/reference/commandline/rm/)
