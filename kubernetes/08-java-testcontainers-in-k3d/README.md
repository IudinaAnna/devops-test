# Task
In k3d run Java [testcontainers](https://java.testcontainers.org/). Make the report which will be accessible from the host machine after testcontainers run.

# Prerequisites

- Follow prerequisites steps 1-5 from [README.md](../../README.md)
- Go to the folder with submodules
```
cd $HOME/training-devops-aiudina/submodules/testcontainers-java
```
- Copy `testcontainers-java` submodule to your working directory 
```
cp -r $HOME/training-devops-aiudina/submodules/testcontainers-java ~/training-devops-aiudina/kubernetes/08-java-testcontainers-in-k3d/src
```
- Go to the necessary folder
```
cd ~/training-devops-aiudina/kubernetes/08-java-testcontainers-in-k3d/src
```
    
# How to run 

1. Create new folder to reports
```
mkdir $HOME/training-devops-aiudina/kubernetes/08-java-testcontainers-in-k3d/report
```
2. Create kubernetes cluster named `demo-cluster` with local container registry named `demo-registry`:
```
k3d cluster create demo-cluster --registry-create demo-registry:12345 --volume $HOME/training-devops-aiudina/kubernetes/08-java-testcontainers-in-k3d/report:/report@server:0
```
3. Get list of clusters
```
k3d cluster ls
```
4. Create new namespace in the current context cluster
```
kubectl create namespace demo
```
5. Switch to `demo` namespace 
```
kubectl ns demo
```
6. Create network
```
docker network create demo-network
```

7. Run [dind](https://shisho.dev/blog/posts/docker-in-docker/) container
```
docker run --privileged -d -p 12380:2375 --name dind -e DOCKER_TLS_CERTDIR="" --network demo-network docker:23.0.1-dind
```

Before build image, go to the [Dockerfile](src/Dockerfile) and in fields `ARG USER_ID= ` and `ARG GROUP_ID= ` add your user and group id, for ex. `ARG USER_ID=1000` 

8. Build [Dockerfile](src/Dockerfile)
```
docker build -f ./Dockerfile --build-arg USER_ID=$(id -u) --build-arg GROUP_ID=$(id -g) -t 08-java-testcontainers-in-k3d:0.1 .
```
9. Add a tag to the image for pushing it to local container registry
```
docker tag 08-java-testcontainers-in-k3d:0.1 localhost:12345/08-java-testcontainers-in-k3d:0.1
```

10. Push the image to the local container registry
```
docker push localhost:12345/08-java-testcontainers-in-k3d:0.1
```
Go to `manifests` folder 

```
cd ~/training-devops-aiudina/kubernetes/08-java-testcontainers-in-k3d/manifests
```
11.  Apply manifest
```
kubectl apply -f ./pod.yml
```

Go to `OpenLens` and watch container logs. <br>
12. In `OpenLens` connect to `demo-cluster` <br>
13. Go to the pods and select `demo` namespace<br>
14. Wait until the containers run<br>
14. Open container logs to see the result<br>
15 Expected result: To see in logs `BUILD SUCCESSFUL` <br>

16. Go to the browser and check reports

```
cd $HOME/training-devops-aiudina/kubernetes/08-java-testcontainers-in-k3d/report/java/reports/tests/test
```
```
pwd
```
Copy path from `pwd` command and add at the end of path `.../index.html` . After paste this path into the search field of your browser. You should see the page with test summary. 

17.  Delete manifest
```
cd ~/training-devops-aiudina/kubernetes/08-java-testcontainers-in-k3d/manifests
```
```
kubectl delete -f ./pod.yml
```
18.  Delete cluster
```
k3d cluster delete demo-cluster
```
19. Delete image
```
docker rmi localhost:12345/08-java-testcontainers-in-k3d:0.1
```
20. Delete dind container
```
docker rm -f dind
```
21. Clean the system
```
docker system prune -f -a 
```


# References
1. [Dockerfile](https://docs.docker.com/engine/reference/builder/)
2. [Docker build](https://docs.docker.com/engine/reference/commandline/build/)
3. [Docker images](https://docs.docker.com/engine/reference/commandline/images/)
4. [Docker Hub image library](https://hub.docker.com/)
5. [Kubernetes](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#logs)
6. [Testcontainers](https://java.testcontainers.org/)
7. [Dockerize](https://github.com/jwilder/dockerize)
   


