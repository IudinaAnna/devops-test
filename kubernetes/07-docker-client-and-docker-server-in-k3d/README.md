# Task
In k3d run pod with two containers: docker-client and docker-server. Run in docker-server `nginxdemos/hello` image. Make sure that the client is connected to the server and you have access to `nginx` from the outside. 
# Prerequisites

1. Follow prerequisites steps 1-4 from [README.md](../../README.md)

2. Go to the folder with cloning project:
```
cd $HOME/training-devops-aiudina/kubernetes/07-docker-client-and-docker-server-in-k3d/manifests
```

  
    
# How to run 


1. Create kubernetes one-node cluster named `demo-cluster` with local container registry named `demo-registry`:
```
k3d cluster create demo-cluster --registry-create demo-registry:12345
```
2. Get list of clusters
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
5. Apply service manifest
```
kubectl apply -f ./service.yml
```
6. Apply deployment manifest
```
kubectl apply -f ./deployment.yml
```
7. Go to `OpenLens` and connect to the `demo-cluster`
8. Go to the pods and select `demo` namespace
9. Wait for all containers to start working. <br>
10. After continue to execute the next steps

11. Forward the host port `15688` to the port `8092`, which is listening by the service
```
k3d cluster edit demo-cluster --port-add 15688:8092@loadbalancer
```
12. Test the newly created service in browser. Write in search field command `http://localhost:15688` or in terminal `curl localhost:15688` command

13.   Delete manifests
```
kubectl delete -f ./deployment.yml
```
```
kubectl delete -f ./service.yml
```
14.  Delete cluster
```
k3d cluster delete demo-cluster
```
15.  Clean the system
```
docker system prune -f -a 
```


# References
1. [Dockerfile](https://docs.docker.com/engine/reference/builder/)
2. [Docker build](https://docs.docker.com/engine/reference/commandline/build/)
3. [Docker images](https://docs.docker.com/engine/reference/commandline/images/)
4. [Docker Hub image library](https://hub.docker.com/)
5. [Kubernetes](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#logs)
6. [Kubernetes services](https://kubernetes.io/docs/concepts/services-networking/service/)
7. [Kubernetes deployments](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/)


