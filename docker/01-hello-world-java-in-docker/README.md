# Task
In this task let's create a simple java class that prints "Hello World!!!" and a Dockerfile that will provide commands to compile this java file and create jar file. In the end, we should get "Hello World!!!" response in the console.
# Prerequisites

1. Follow prerequisites steps 1-4 from [README.md](../../README.md)

2. Go to the folder with the cloning project:
```
cd $HOME/training-devops-aiudina/docker/01-hello-world-java-in-docker/src
```

# How to run 

1. [Build](https://docs.docker.com/engine/reference/commandline/build/) our new image. 

```
docker build -f ./Dockerfile -t 01-java-hello-world-in-docker:0.1 .
```

2. Get the list of all [images](https://docs.docker.com/engine/reference/commandline/images/) to check if 01-java-hello-world-in-docker:0.1 was created 
```
docker images
```

3. [Run](https://docs.docker.com/engine/reference/commandline/run/) the container with 01-java-hello-world-in-docker:0.1 image
  ```
   docker run --name 01-task 01-java-hello-world-in-docker:0.1
  ```
The output in the console: 
Hello World!!!<br>

4. [Stop](https://docs.docker.com/engine/reference/commandline/stop/) the running container
```
docker stop 01-task
```
5. Remove the stopped container
```
docker rm 01-task
```
6. Remove the image
```
docker rmi 01-java-hello-world-in-docker:0.1
```



# References
1. [Guide to Jar file in java](https://www.baeldung.com/java-create-jar)
2. [How to manage jar files in linux terminal](https://www.tecmint.com/create-and-execute-jar-file-in-linux/)
3. [Dockerfile](https://docs.docker.com/engine/reference/builder/)
4. [Docker build](https://docs.docker.com/engine/reference/commandline/build/)
5. [Docker images](https://docs.docker.com/engine/reference/commandline/images/)
6. [Docker run](https://docs.docker.com/engine/reference/commandline/run/)
7. [Docker ps ](https://docs.docker.com/engine/reference/commandline/ps/)
8. [Docker Hub image library](https://hub.docker.com/)
9. [Docker stop](https://docs.docker.com/engine/reference/commandline/stop/)
10. [Docker rm](https://docs.docker.com/engine/reference/commandline/rm/)

