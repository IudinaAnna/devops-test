
# Task
In this task let's create a Python  program that will return "Hello, <name_value>" and a Dockerfile that will provide commands to compile this python file. In the end, we should get, for example, "Hello, Anna" response in the console.

# Prerequisites 

1. Follow prerequisites steps 1-4 from [README.md](../../README.md)
2. Go to the folder with the cloning project:
```
cd $HOME/training-devops-aiudina/docker/02-python-hello-world-in-docker/src
```

# How to run 


1. [Build](https://docs.docker.com/engine/reference/commandline/build/) our new image

```
docker build -f ./Dockerfile -t 02-python-hello-world-in-docker:0.1 .
```

2. Get the list of [images](https://docs.docker.com/engine/reference/commandline/images/) to check if 02-python-hello-world-in-docker:0.1 was created
```
docker images
```

3. [Run](https://docs.docker.com/engine/reference/commandline/run/) our builded image. 
```
docker run --name 02-task 02-python-hello-world-in-docker:0.1 --name Anna
```

The output in the console: <br>

![output1](https://github.com/Alliedium/training-devops-aiudina/assets/81852283/a59c7543-a8bd-4993-9b75-c4cdd3d41f2d)

You can also check the answer using the command without the flag --name: 

```
docker run --name 02-task-2 02-python-hello-world-in-docker:0.1
```
![out2png](https://github.com/Alliedium/training-devops-aiudina/assets/81852283/dac789ae-5f8a-4070-a285-f717968b1ad7)

The difference in responses is due to our python script.

4. [Stop](https://docs.docker.com/engine/reference/commandline/stop/) the running container
```
docker stop 02-task 02-task-2
```
5. Remove the stopped container
```
docker rm 02-task 02-task-2
```
6. Remove the image
```
docker rmi 02-python-hello-world-in-docker:0.1
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


