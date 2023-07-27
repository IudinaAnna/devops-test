# Task
In k3d run Python [testcontainers](https://java.testcontainers.org/). Make the report which will be accessible from the host machine after testcontainers run.

# Prerequisites

- Follow prerequisites steps 1-5 from [README.md](../../README.md)
- Go to the folder with submodules
```
cd $HOME/training-devops-aiudina/submodules/testcontainers-python
```
- Copy `testcontainers-python` submodule to your working directory 
```
cp -r $HOME/training-devops-aiudina/submodules/testcontainers-python ~/training-devops-aiudina/kubernetes/09-python-testcontainers-in-k3d/src
```
- Go to the necessary folder
```
cd ~/training-devops-aiudina/kubernetes/09-python-testcontainers-in-k3d/src
```
    
# How to run 

1. Create new folder to reports
```
mkdir $HOME/training-devops-aiudina/kubernetes/09-python-testcontainers-in-k3d/report
```
2. Create kubernetes one-node cluster named `demo-cluster` with local container registry named `demo-registry`:
```
k3d cluster create demo-cluster --registry-create demo-registry:12345 --volume $HOME/training-devops-aiudina/kubernetes/09-python-testcontainers-in-k3d/report:/report@server:0
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

Before build image, set the default values of `USER_ID` and  GROUP_ID in [Dockerfile](src/Dockerfile) Use the command below to set values to your personal user and group id. 
```
sed -i "s/ARG USER_ID=1000/ARG USER_ID=$(id -u)/" Dockerfile
```
```
sed -i "s/ARG GROUP_ID=1000/ARG GROUP_ID=$(id -g)/" Dockerfile 
```
8. Build [Dockerfile](src/Dockerfile).
```shell
docker build -f ./Dockerfile -t 09-python-testcontainers-in-k3d:0.1 .
```
If you want to replace values for `USER_ID` and `GROUP_ID` use the command below. Replace `<username>` with the name of the existing user
```shell
docker build -f ./Dockerfile --build-arg USER_ID=$(id <username> -u) --build-arg GROUP_ID=$(id <username> -g) -t 09-python-testcontainers-in-k3d:0.1 .
```
9. Add a tag to the image for pushing it to local container registry
```
docker tag 09-python-testcontainers-in-k3d:0.1 localhost:12345/09-python-testcontainers-in-k3d:0.1
```

10. Push the image to the local container registry
```
docker push localhost:12345/09-python-testcontainers-in-k3d:0.1
```
Go to `manifests` folder 

```
cd ~/training-devops-aiudina/kubernetes/09-python-testcontainers-in-k3d/manifests
```
11.  Apply manifest
```
kubectl apply -f ./pod.yml
```
12. Go to `OpenLens` and watch container logs.
          
    12.1. In OpenLens connect to demo-cluster.   
    12.2. Go to the pods and select `demo` namespace.   
    12.3. Wait until the containers run.   
    12.4. Open container logs to see the result.   
    12.5. Expected result: To see in logs that all tests passed.   

14. Check report in the browser
```
cd ~/training-devops-aiudina/kubernetes/09-python-testcontainers-in-k3d/report/python
```
```
pwd
```
Copy path from pwd command and add at the end of path `/report.html`. Then paste this path into the search field of your browser. You should see the page with test summary. <br>

14.  Delete manifest
```
kubectl delete -f ~/training-devops-aiudina/kubernetes/09-python-testcontainers-in-k3d/manifests/pod.yml
```

15.  Delete cluster
```
k3d cluster delete demo-cluster
```
16. Delete image
```
docker rmi localhost:12345/09-python-testcontainers-in-k3d:0.1
```
17. Delete `dind` container
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
6. [Testcontainers](https://testcontainers.com/)
7. [Dockerize](https://github.com/jwilder/dockerize)
   


