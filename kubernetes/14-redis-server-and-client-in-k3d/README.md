# Task
In k3d run redis-server and redis-client. Make the report which will be accessible from the host machine after deleting the manifest. 
# Prerequisites

1. Follow prerequisites steps 1-4 from [README.md](../../README.md)
 
# How to run 
1. Create new folder to reports
```
mkdir $HOME/training-devops-aiudina/kubernetes/14-redis-server-and-client-in-k3d/data
```
2. Create kubernetes one-node cluster named `demo-cluster-1` with local container registry named `demo-registry`:
```
k3d cluster create demo-cluster --registry-create demo-registry:12345 \
--volume $HOME/training-devops-aiudina/kubernetes/14-redis-server-and-client-in-k3d/data:/data@server:0
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
If `ns` is not installed in your machine, use below command: 
```
kubectl config set-context --curent --namespace `demo`
```
Before build image, set the default values of `USER_ID` and `GROUP_ID` in Dockerfile. Use the commands below to set values to your personal user and group id.
```
sed -i "s/ARG USER_ID=1000/ARG USER_ID=$(id -u)/" $HOME/training-devops-aiudina/kubernetes/14-redis-server-and-client-in-k3d/src/Dockerfile
```
```
sed -i "s/ARG GROUP_ID=1000/ARG GROUP_ID=$(id -g)/" $HOME/training-devops-aiudina/kubernetes/14-redis-server-and-client-in-k3d/src/Dockerfile
```
6. [Build](https://docs.docker.com/engine/reference/commandline/build/) our new image.
```
docker build -f $HOME/training-devops-aiudina/kubernetes/14-redis-server-and-client-in-k3d/src/Dockerfile -t 14-redis-server-and-client-in-k3d:0.1 .
```
If you want to replace values for `USER_ID` and `GROUP_ID` use the command below. Replace `<username>` with the name of the existing user.
```
docker build -f $HOME/training-devops-aiudina/kubernetes/14-redis-server-and-client-in-k3d/src/Dockerfile --build-arg USER_ID=$(id <username> -u) --build-arg GROUP_ID=$(id <username> -g) -t 14-redis-server-and-client-in-k3d:0.1 .
```
7. Add a tag to the image for pushing it to local container registry
```
docker tag 14-redis-server-and-client-in-k3d:0.1 localhost:12345/14-redis-server-and-client-in-k3d:0.1
```
8. Push the image to the local container registry
```
docker push localhost:12345/14-redis-server-and-client-in-k3d:0.1
```
9. Apply manifest
```
kubectl apply -f $HOME/training-devops-aiudina/kubernetes/14-redis-server-and-client-in-k3d/manifests/pod.yml
```
10. Go to `OpenLens` to create database inside `redis-server` container
* In OpenLens connect to `demo-cluster-1`
* Go to the pods and select `demo` namespace
* Wait until the containers run
* Open `shell` for `redis-server` container and execute next commands:<br>
`redis-cli` <br>
`set name anna`<br>
`get name`<br>
`save`<br>
* Expected result: To see in shell, after `save` command `OK`.
* After execute `exit` command
11. To check reports go to  the `report` folder and do `ls -lha` command
```
ls -lha $HOME/training-devops-aiudina/kubernetes/14-redis-server-and-client-in-k3d/report
```
To check reports in browser, do `pwd` command, copy the path and paste this path into the search field of your browser. You should see the page with test summary.
12.  Delete pod
```
kubectl delete -f $HOME/training-devops-aiudina/kubernetes/14-redis-server-and-client-in-k3d/manifests/pod.yml
```
13. Delete the image 
```
docker rmi 14-redis-server-and-client-in-k3d:0.1
```
14.  Delete cluster
```
k3d cluster delete demo-cluster-1
```


# References
1. [Dockerfile](https://docs.docker.com/engine/reference/builder/)
2. [Docker build](https://docs.docker.com/engine/reference/commandline/build/)
3. [Docker images](https://docs.docker.com/engine/reference/commandline/images/)
4. [Docker Hub image library](https://hub.docker.com/)
5. [Kubernetes](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#logs)
6. [Redis](https://redis.io/docs/about/)

