# Task
In this task run HelloWorld.java file in k3d
# Prerequisites

1. Follow prerequisites steps 1-4 from [README.md](../../README.md)

2. Go to the folder with the cloning project:
```
cd $HOME/training-devops-aiudina/kubernetes/01-hello-world-java-in-k3d/src
```

  
    
# How to run 

1. Create kubernetes one-node cluster named `demo-cluster-1` with local container registry named `demo-registry`:
```
k3d cluster create demo-cluster-1 --registry-create demo-registry:12345
```
2. Get the list of clusters
```
k3d cluster ls
```
3. Create new namespace in the current context cluster
```
kubectl create namespace demo
```
4. Switch to a new namespace 
```
kubectl ns 
```

5. [Build](https://docs.docker.com/engine/reference/commandline/build/) our new image. 

```
docker build -f ./Dockerfile -t 01-hello-world-java-in-k3d:0.1 .
```

6. Add a tag to the image for pushing it to the local container registry
```
docker tag 01-hello-world-java-in-k3d:0.1 localhost:12345/01-hello-world-java-in-k3d:0.1
```
7. Get the list of images to make sure that the tag has been added
```
docker images
```
8. Push the image to the local container registry
```
docker push localhost:12345/01-hello-world-java-in-k3d:0.1
```
9. Go to the `manifests` folder
```
cd $HOME/training-devops-aiudina/kubernetes/01-hello-world-java-in-k3d/manifests
```
10. Apply manifest
```
kubectl apply -f ./pod.yml
```

You can see the result in the logs in `OpenLens`
or by using the command ` kubectl logs -c [container_name] [pod_name]`

11. Delete pod
```
kubectl delete -f ./pod.yml
```
12. Delete cluster
```
k3d cluster delete demo-cluster-1
```
13. Delete image
```
docker rmi /01-hello-world-java-in-k3d:0.1
```
13. Clean the system
```
docker system prune -f -a 
```


# References
1. [Dockerfile](https://docs.docker.com/engine/reference/builder/)
2. [Docker build](https://docs.docker.com/engine/reference/commandline/build/)
3. [Docker images](https://docs.docker.com/engine/reference/commandline/images/)
4. [Docker Hub image library](https://hub.docker.com/)
5. [Kubernetes](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#logs)

