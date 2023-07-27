# Task
In k3d run Java/Python/Node [testcontainers](https://java.testcontainers.org/) via argo workflows via steps. Make the report which will be accessible from the host machine after testcontainers run.

# Prerequisites

- Follow prerequisites steps 1-5 from [README.md](../../README.md)
- Go to the folder with submodules
```
cd $HOME/training-devops-aiudina/submodules
```
- Copy `testcontainers-java` submodule to your working directory 
```
cp -r testcontainers-java testcontainers-python testcontainers-node  ~/training-devops-aiudina/kubernetes/12-java-node-python-testcontainers-via-workflows/src
```
- Go to the necessary folder
```
cd ~/training-devops-aiudina/kubernetes/12-java-node-python-testcontainers-via-workflows/src
```    
# How to run 

1. Create a new folder for reports
```
mkdir $HOME/training-devops-aiudina/kubernetes/12-java-node-python-testcontainers-via-workflows/report
```
2. Create kubernetes cluster named `demo-cluster` with a local container registry named `demo-registry`:
```
k3d cluster create demo-cluster --registry-create demo-registry:12345 --volume $HOME/training-devops-aiudina/kubernetes/12-java-node-python-testcontainers-via-workflows/report:/report
```
3. Get the list of clusters
```
k3d cluster ls
```
4. Create new namespace in the current context cluster
```
kubectl create namespace argo
```
5. Switch to `argo` namespace 
```
kubectl ns argo
```
6. Via helm install argo workflows
```
helm repo add argo https://argoproj.github.io/argo-helm
```
```
helm install argo argo/argo-workflows
```
6. Create network
```
docker network create dind-network
```

7. Run [dind](https://shisho.dev/blog/posts/docker-in-docker/) container
```
docker run --privileged -d -p 12381:2375 --name dind -e DOCKER_TLS_CERTDIR="" --network dind-network docker:23.0.1-dind
```
Before build image, set the default values of `USER_ID` and `GROUP_ID` in Dockerfiles. Use the commands bellow to set values to your personal user and group id.

```
sed -i "s/ARG USER_ID=1000/ARG USER_ID=$(id -u)/" Dockerfile.java Dockerfile.python Dockerfile.node  
``` 
```
sed -i "s/ARG GROUP_ID=1000/ARG GROUP_ID=$(id -g)/" Dockerfile.java Dockerfile.python Dockerfile.node  
```

8. Build Dockerfiles

```
docker build -f ./Dockerfile.java -t 12-java-testcontainers-via-workflows:0.1 .
```
```
docker build -f ./Dockerfile.python -t 12-python-testcontainers-via-workflows:0.1 .
```
```
docker build -f ./Dockerfile.node -t 12-node-testcontainers-via-workflows:0.1 .
```
If you want to replace values for `USER_ID` and `GROUP_ID` use the command below. Replace `<username>` with the name of the existing user

```
docker build -f ./Dockerfile.java --build-arg USER_ID=$(id <username> -u) --build-arg GROUP_ID=$(id <username> -g) -t 12-java-testcontainers-via-workflows:0.1 .
```
```
docker build -f ./Dockerfile.python --build-arg USER_ID=$(id <username> -u) --build-arg GROUP_ID=$(id <username> -g) -t 12-python-testcontainers-via-workflows:0.1 .
```
```
docker build -f ./Dockerfile.node --build-arg USER_ID=$(id <username> -u) --build-arg GROUP_ID=$(id <username> -g) -t 12-node-testcontainers-via-workflows:0.1 .
```

9. Add a tags to the images for pushing it to local container registry
```
docker tag 12-java-testcontainers-via-workflows:0.1 localhost:12345/12-java-testcontainers-via-workflows:0.1
```
```
docker tag 12-python-testcontainers-via-workflows:0.1 localhost:12345/12-python-testcontainers-via-workflows:0.1
```
```
docker tag 12-node-testcontainers-via-workflows:0.1 localhost:12345/12-node-testcontainers-via-workflows:0.1
```

10. Push the images to the local container registry
```
docker push localhost:12345/12-java-testcontainers-via-workflows:0.1
```
``` 
docker push localhost:12345/12-python-testcontainers-via-workflows:0.1
```
```
docker push localhost:12345/12-node-testcontainers-via-workflows:0.1
```
Go to the `manifests` folder 

```
cd ~/training-devops-aiudina/kubernetes/12-java-node-python-testcontainers-via-workflows/manifests
```
11.  Apply manifest
```
kubectl apply -f ./workflow.yml
```

12. Go to `OpenLens` and watch container logs. <br>
    
* Open `OpenLens` and connect to `demo-cluster`

* Go to the pods and select `argo` namespace

* Wait until the pods run

* Open containers logs to see result

* Expected result: To see that all tests passed in logs

*** If you gave a problems with the pods after applying - they will not run. Then delete `workflow.yml` manifest and apply it again.

13. To check reports go to the `report` folder and do `ls -lha` command

```
cd ~/training-devops-aiudina/kubernetes/12-java-node-python-testcontainers-via-workflows/report
```
To check the report in the browser do `pwd` command, copy the path and paste it into the search field of your browser. You should see the page with three folders with reports inside them: `java/reports/tests/test`, `python` and `node`.

14.   Delete manifest
```
cd ~/training-devops-aiudina/kubernetes/12-java-node-python-testcontainers-via-workflows/manifests
```
```
kubectl delete -f ./workflow.yml
```

15.   Delete cluster
```
k3d cluster delete demo-cluster
```
16.  Delete dind container
```
docker rm -f dind
```
17.   Clean the system
```
docker system prune -f -a 
```


# References
1. [Dockerfile](https://docs.docker.com/engine/reference/builder/)
2. [Docker build](https://docs.docker.com/engine/reference/commandline/build/)
3. [Docker images](https://docs.docker.com/engine/reference/commandline/images/)
4. [Docker Hub image library](https://hub.docker.com/)
5. [Kubernetes](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#logs)
6. [Testcontainers](https://testcontainers.org/)
7. [Dockerize](https://github.com/jwilder/dockerize)
8. [Argo Workflows](https://argoproj.github.io/argo-workflows/quick-start/)
   


