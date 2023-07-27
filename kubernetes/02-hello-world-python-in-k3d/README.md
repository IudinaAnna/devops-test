# Task
In this task run python Hello World in k3d
# Prerequisites

1. Follow prerequisites steps 1-4 from [README.md](../../README.md)

2. Go to the folder with the cloned project:
```
cd $HOME/training-devops-aiudina/kubernetes/02-hello-world-python-in-k3d/src
```

  
    
# How to run 

Consider the commands we need to run our application
1. Create kubernetes one-node cluster named `demo-cluster-1` with local container registry named `demo-registry`:
```
k3d cluster create demo-cluster-1 --registry-create demo-registry:12345
```
2. Find the cluster `demo-cluster-1` in the list 
```
k3d cluster ls
```
3. Create new namespace in the current context cluster
```
kubectl create namespace demo
```
4. Switch to `demo` namespace 
```
kubectl ns demo
```

5. [Build](https://docs.docker.com/engine/reference/commandline/build/) our new image. 

```
docker build -f ./Dockerfile -t 02-hello-world-python-in-k3d:0.1 .
```

6. Add a tag to the image for pushing it to local container registry
```
docker tag 02-hello-world-python-in-k3d:0.1 localhost:12345/02-hello-world-python-in-k3d:0.1
```
7. Find the tagged image
```
docker images
```
8. Push the image to the local container registry
```
docker push localhost:12345/02-hello-world-python-in-k3d:0.1
```
9. Go to the `manifests` folder
```
cd $HOME/training-devops-aiudina/kubernetes/02-hello-world-python-in-k3d/manifests
```
10. Apply manifest
```
kubectl apply -f ./pod.yml
```
To see the logs open `OpenLens`
11. Connect to the cluster `demo-cluster-1`  
12. Find pod in the corresponding namespace
13. Open the pod logs<br>

Message in the logs should be `Hello, Anna`


14. Delete pod
```
kubectl delete -f ./pod.yml
```
15. Delete cluster
```
k3d cluster delete demo-cluster-1
```
16. Clean the system
```
docker system prune -f -a 
```


# References
1. [Dockerfile](https://docs.docker.com/engine/reference/builder/)
2. [Docker build](https://docs.docker.com/engine/reference/commandline/build/)
3. [Docker images](https://docs.docker.com/engine/reference/commandline/images/)
4. [Docker Hub image library](https://hub.docker.com/)
5. [Kubernetes](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#logs)
6. [How to use OpenLens](https://www.virtualizationhowto.com/2022/11/openlens-kubernetes-ide-opensource-lens-desktop/)

