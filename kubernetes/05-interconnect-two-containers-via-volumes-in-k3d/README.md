# Task
In this task create pod with two containers: writer and reader. Container `writer` should writes `Hello World` in `test.txt` file.
Container `reader` should reads this file and prints file content. Make them interconnect via volumes.

# Prerequisites

1. Follow prerequisites steps 1-4 from [README.md](../../README.md)

2. Go to the folder with the cloning project:
```
cd $HOME/training-devops-aiudina/kubernetes/05-interconnect-two-containers-via-volumes-in-k3d/manifests
```

  
    
# How to run 

1. Create kubernetes one-node cluster named `demo-cluster` with local container registry named `demo-registry`:
```
k3d cluster create demo-cluster --registry-create demo-registry:12345
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
5.  Apply manifest
```
kubectl apply -f ./pod.yml
```

You can see the result in the logs in `OpenLens`
or by using the command `kubectl logs -c [container_name] [pod_name]`

6. Delete pod
```
kubectl delete -f ./pod.yml
```
7. Delete cluster
```
k3d cluster delete demo-cluster
```
8. Clean the system
```
docker system prune -f -a 
```


# References
1. [Dockerfile](https://docs.docker.com/engine/reference/builder/)
2. [Docker build](https://docs.docker.com/engine/reference/commandline/build/)
3. [Docker images](https://docs.docker.com/engine/reference/commandline/images/)
4. [Docker Hub image library](https://hub.docker.com/)
5. [Kubernetes](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#logs)

