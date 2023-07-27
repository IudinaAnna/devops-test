# Task
In this task create a deployment with 4 pods from `nginxdemos/hello` image, which will be accessible from the outside. Show the load balancing.

# Prerequisites

1. Follow prerequisites steps 1-4 from [README.md](../../README.md)

2. Go to the folder with cloning project:
```
cd $HOME/training-devops-aiudina/kubernetes/04-deployment-with-4-pods/manifests
```

  
    
# How to run 

1. Create kubernetes one-node cluster named `demo-cluster-1` with local container registry named `demo-registry`:
```
k3d cluster create demo-cluster-1 --registry-create demo-registry:12345
```
2. Find the `demo-cluster-1` cluster in the list
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
5.  Apply service manifest
```
kubectl apply -f ./service.yml
```
6. Apply deployment manifest
```
kubectl apply -f ./deployment.yml
```

7. Wait until each pod will be up and after do this command in terminal :
```
k3d cluster edit demo-cluster-1 --port-add 14560:4590@loadbalancer
```
8. Test the newly created nginx service 
```
curl localhost:14560
```
To see `loadbalancing` do this command several times and compare IP adresses

9.  Delete service
```
kubectl delete -f ./service.yml
```
10.  Delete deployment
```
kubectl delete -f ./deployment.yml
```
11. Delete cluster
```
k3d cluster delete demo-cluster-1
```
12. Clean the system
```
docker system prune -f -a 
```


# References
1. [Dockerfile](https://docs.docker.com/engine/reference/builder/)
2. [Docker build](https://docs.docker.com/engine/reference/commandline/build/)
3. [Docker images](https://docs.docker.com/engine/reference/commandline/images/)
4. [Docker Hub image library](https://hub.docker.com/)
5. [Kubernetes](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#logs)
6. [Load balancing](https://devopswithkubernetes.com/part-1/3-introduction-to-networking)
7. [Replicas](https://kubernetes.io/docs/concepts/workloads/controllers/replicaset/)

