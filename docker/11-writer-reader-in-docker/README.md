
# Task
In this task let's create a writer-reader example using dockerize.
# Prerequisites 

1. Follow prerequisites steps 1-4 from [README.md](../../README.md)
2. Go to the folder with the cloning project:
```
cd $HOME/training-devops-aiudina/docker/11-writer-reader-in-docker/src
```

# How to run 


1. [Build](https://docs.docker.com/engine/reference/commandline/build/) our new image

```
docker build -f ./Dockerfile -t 11-writer-reader-in-docker:0.1 .
```

2. Get the list of [images](https://docs.docker.com/engine/reference/commandline/images/) to check if 11-writer-reader-in-docker:0.1 was created
```
docker images
```

3. [Run](https://docs.docker.com/engine/reference/commandline/run/) our builded image. 
  ```
   docker run --name 11-task 11-writer-reader-in-docker:0.1 
  ```
4. Remove the container
```
docker rm -f 11-task
```
5. Remove image
```
docker rmi 11-writer-reader-in-docker:0.1 
```
6. Clean the system
```
docker system prune -f -a 
```
# References
1. [Dockerfile reference](https://docs.docker.com/engine/reference/builder/)
2. [Docker build](https://docs.docker.com/engine/reference/commandline/build/)
3. [Docker images](https://docs.docker.com/engine/reference/commandline/images/)
4. [Docker run](https://docs.docker.com/engine/reference/commandline/run/)
5. [Docker Hub image library](https://hub.docker.com/)
6. [Docker rm ](https://docs.docker.com/engine/reference/commandline/rm/)


