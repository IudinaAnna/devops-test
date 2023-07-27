# Task
In k3d run Java [testcontainers](https://java.testcontainers.org/) via argo workflows. Make the report which will be accessible from the host machine after testcontainers run.

# Prerequisites

- Follow prerequisites steps 1-5 from [README.md](../../README.md)
- Go to the folder with submodules
```
cd $HOME/training-devops-aiudina/submodules/testcontainers-java
```
- Copy `testcontainers-java` submodule to your working directory 
```
cp -r $HOME/training-devops-aiudina/submodules/testcontainers-java ~/training-devops-aiudina/kubernetes/11-java-testcontainers-via-workflows/src
```
- Go to the necessary folder
```
cd ~/training-devops-aiudina/kubernetes/11-java-testcontainers-via-workflows/src
```    
# How to run 

1. Create new folder to reports
```
mkdir $HOME/training-devops-aiudina/kubernetes/11-java-testcontainers-via-workflows/report
```
2. Create kubernetes cluster named `demo-cluster` with local container registry named `demo-registry`:
```
k3d cluster create demo-cluster --registry-create demo-registry:12345 --volume $HOME/training-devops-aiudina/kubernetes/11-java-testcontainers-via-workflows/report:/report
```
3. Get list of clusters
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
docker network create demo-network
```

7. Run [dind](https://shisho.dev/blog/posts/docker-in-docker/) container
```
docker run --privileged -d -p 12380:2375 --name dind -e DOCKER_TLS_CERTDIR="" --network demo-network docker:23.0.1-dind
```

Before build image, set the default values of `USER_ID` and `GROUP_ID` in [Dockerfile](src/Dockerfile). Use the commands bellow to set values to your personal user and group id.
```
sed -i "s/ARG USER_ID=1000/ARG USER_ID=$(id -u)/" Dockerfile
```
```
sed -i "s/ARG GROUP_ID=1000/ARG GROUP_ID=$(id -g)/" Dockerfile
```

8. Build [Dockerfile](src/Dockerfile)

```
docker build -f ./Dockerfile -t 11-java-testcontainers-via-workflows:0.1 .
```
If you want to replace values for `USER_ID` and `GROUP_ID` use the command below. Replace `<username>` with the name of the existing user
```
docker build -f ./Dockerfile --build-arg USER_ID=$(id <username> -u) --build-arg GROUP_ID=$(id <username> -g) -t 11-java-testcontainers-via-workflows:0.1 .
```
9. Add a tag to the image for pushing it to local container registry
```
docker tag 11-java-testcontainers-via-workflows:0.1 localhost:12345/11-java-testcontainers-via-workflows:0.1
```

10.   Push the image to the local container registry
```
docker push localhost:12345/11-java-testcontainers-via-workflows:0.1
```
Go to `manifests` folder 

```
cd ~/training-devops-aiudina/kubernetes/11-java-testcontainers-via-workflows/manifests
```
11.  Apply manifest
```
kubectl apply -f ./workflow.yml
```

12. Go to `OpenLens` to see container logs. <br>

* Open `OpenLens` and connect to `demo-cluster`

* Go to the pods and select `demo` namespace

* Wait until the containers run

* Open containers logs to see result

* Expected result: To see `BUILD SUCCESSFUL` in logs

12.  To check reports go to `report` folder and do `ls -lha` command to check rights

```
cd ~/training-devops-aiudina/kubernetes/11-java-testcontainers-via-workflows/report/java/reports/tests/test
```
To see reports in browser dp `pwd`, copy path and paste it into search field in your browser. At the end of path add `/index.html` <br>
You should see the page with test summary. 

14.  Delete manifest
```
kubectl delete -f ./workflow.yml
```

15.  Delete cluster
```
k3d cluster delete demo-cluster
```
16. Delete image
```
docker rmi localhost:12345/11-java-testcontainers-via-workflows:0.1
```
17. Delete dind container
```
docker rm -f dind
```
18.  Clean the system
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
8. [Argo Workflows](https://argoproj.github.io/argo-workflows/)
   


