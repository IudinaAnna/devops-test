# Task
In this task run `redis-server` and `redis-client` containers. Make accessible the database to the host after the container stops

## Prerequisites
- Follow prerequisites steps 1-4 from [README.md](../../README.md)

- Go to the necessary folder
```
cd ~/training-devops-aiudina/docker/10-redis-client-and-server-in-docker/src
```


## How to run

1. Create [network](https://docs.docker.com/engine/reference/commandline/network_create/)
```
docker network create redisNetwork
```
2. For reports create a new folder `/report` 
```
mkdir $HOME/training-devops-aiudina/docker/10-redis-client-and-server-in-docker/report
```
Before build image, set the default values of `USER_ID` and `GROUP_ID` in Dockerfile. Use the command below to set values to your personal user and group id.
```
sed -i "s/ARG USER_ID=1000/ARG USER_ID=$(id -u)/" Dockerfile
```
```
sed -i "s/ARG GROUP_ID=1000/ARG GROUP_ID=$(id -g)/" Dockerfile 
```
3. Build [Dockerfile](src/Dockerfile)
```
docker build -f ./Dockerfile -t 10-redis-client-and-server-in-docker:0.1 .
```
If you want to replace values for `USER_ID` and `GROUP_ID` use the command below. Replace <username> with the name of the existing user
```
docker build -f ./Dockerfile --build-arg USER_ID=$(id <username> -u) --build-arg GROUP_ID=$(id <username> -g) -t 10-redis-client-and-server-in-docker:0.1 .
```
4. Run redis-server with 10-redis-client-and-server-in-docker:0.1 image 
```
docker run -d --name my-redis-server --network redisNetwork --mount type=bind,source=$HOME/training-devops-aiudina/docker/10-redis-client-and-server-in-docker/report,target=/data 10-redis-client-and-server-in-docker:0.1 
```
4. Run redis-client 
```
docker run -it --rm --name redis-client --network redisNetwork redis redis-cli -h my-redis-server
```
5. Inside `redis-client` add new data in database. Use these instructions:
`set name Anna`, `get name`, `save`, `exit`.

6. To check if our database was created at host do `ls -lha` command. 
```
ls -lha ~/training-devops-aiudina/docker/10-redis-client-and-server-in-docker/report
```
You should see `dump.rdb` file in output. <br>

7. After all steps clean the system 
```
docker rm -f  my-redis-server
```
```
docker rmi 10-redis-client-and-server-in-docker:0.1
```
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
 9. [Redis](https://redis.io/)

