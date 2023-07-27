
# Task
Interconnect in docker two containers: postgres-client and postgres-server using network aliases. 

# Prerequisites 

1. Follow prerequisites steps 1-4 from [README.md](../../README.md)
2. Go to the folder with the cloning project:
```
cd $HOME/training-devops-aiudina/docker/06-interconnect-in-docker-postgres-client-and-server
```

# How to run 

1. Create network
```
docker network create demo-network
```
2. Run `postgres-server`
```
docker run --rm --name postgres-server \
--network demo-network --network-alias postgres-alias \
-e POSTGRES_USER=aiudina \
-e POSTGRES_PASSWORD=123 \
-d \
-p 6432:5432 \
postgres:14.5-alpine3.16
```

3. Run `postgres-client`

```
docker run -it --rm --name postgres-client \
--network demo-network \
postgres:14.5-alpine3.16 \
psql -h postgres-alias -U aiudina
```
To connect use password `123` from second step <br>
To get out of the `postgres-client` use the command:
```
\q
```
4. Clean the system
```
docker rm -f postgres-server
```
```
docker rmi postgres:14.5-alpine3.16
```
```
docker system prune -f -a 
```
# References
1. [Docker run](https://docs.docker.com/engine/reference/commandline/run/)
2. [Docker Hub image library](https://hub.docker.com/)
3. [Docker rm ](https://docs.docker.com/engine/reference/commandline/rm/)
4. [PostgreSQL](https://www.postgresqltutorial.com/postgresql-getting-started/what-is-postgresql/)
5. [Network aliases](https://www.geeksforgeeks.org/alias-secondary-ip-address/)



