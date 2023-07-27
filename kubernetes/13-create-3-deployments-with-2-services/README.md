# Task
In k3d create 3 deployments with `nginxdemos/hello` image and expose it to using 2 services. 
First service (accessible at port 8092) - to provide load balancing for the 1st and 2nd deployments. Second service (accessible at port 8093) - to provide load balancing for the 2nd and 3rd deployments. 

# Prerequisites

1. Follow prerequisites steps 1-4 from [README.md](../../README.md)

2. Go to the folder with the cloning project:
```
cd $HOME/training-devops-aiudina/kubernetes/13-create-3-deployments-with-2-services/manifests
```
    
# How to run 

1. Create kubernetes one-node cluster named `demo-cluster-1` with a local container registry named `demo-registry`:
```
k3d cluster create demo-cluster-1 --registry-create demo-registry:12345
```
2. Get the list of clusters
```
k3d cluster ls
```
3. Create a new namespace in the current context cluster
```
kubectl create namespace demo
```
4. Switch to a `demo` namespace 
```
kubectl ns demo
```
If `ns` is not installed on your machine, use below command:
```
kubectl config set-context --current --namespace `demo`
```
5.  Apply `service` manifests

```
kubectl apply -f ./service1.yml
```
```
kubectl apply -f ./service2.yml
```
6. Apply `deployments`
```
kubectl apply -f ./deployment1.yml
```
```
kubectl apply -f ./deployment2.yml
```
```
kubectl apply -f ./deployment3.yml
```

7. Forward the host ports to the ports, which are listening by the service
```
k3d cluster edit demo-cluster-1 --port-add 15999:8092@loadbalancer
```
```
k3d cluster edit demo-cluster-1 --port-add 14999:8093@loadbalancer
```

8. Check the newly created services
```
curl localhost:15999
```
```
curl localhost:14999
```
To see the load balancing do commands from `8` step multiple times. In the outputs, you will see that service addresses and names are changing, proving load balancing.

9. Delete manifests
```
kubectl delete -f ./service1.yml
```
```
kubectl delete -f ./service2.yml
```
```
kubectl delete -f ./deployment1.yml
```
```
kubectl delete -f ./deployment2.yml
```
```
kubectl delete -f ./deployment3.yml
```
10.  Delete cluster
```
k3d cluster delete demo-cluster-1
```


# References
1. [Dockerfile](https://docs.docker.com/engine/reference/builder/)
2. [Docker build](https://docs.docker.com/engine/reference/commandline/build/)
3. [Docker images](https://docs.docker.com/engine/reference/commandline/images/)
4. [Docker Hub image library](https://hub.docker.com/)
5. [Kubernetes](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#logs)
6. [Kubernetes services](https://kubernetes.io/docs/tutorials/kubernetes-basics/expose/expose-intro/)
7. [Kubernetes deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/)

