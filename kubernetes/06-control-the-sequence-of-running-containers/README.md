# Task
How to control the sequence of containers running based on [K-05]() writer-reader example. Make it via Job/InitContainers/Dockerize/Sleep

# Prerequisites

1. Follow prerequisites steps 1-4 from [README.md](../../README.md)

2. Go to the folder with cloning project:
```
cd $HOME/training-devops-aiudina/kubernetes/06-control-the-sequence-of-running-containers/src
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
For `dockerize` we need an image that will contain it.

5. Build image which include dockerize
```
docker build -f ./Dockerfile -t 06-control-the-sequence-dockerize:0.1 .
```
6. Add a tag to the image for pushing it to local registry
```
docker tag 06-control-the-sequence-dockerize:0.1 localhost:12345/06-control-the-sequence-dockerize:0.1
```
7. Push the image to the local registry
```
docker push localhost:12345/06-control-the-sequence-dockerize:0.1
```
Go to the `manifests folder` for applying manifests

```
cd $HOME/training-devops-aiudina/kubernetes/06-control-the-sequence-of-running-containers/manifests
```
8. Apply Dockerize manifest
```
kubectl apply -f ./dockerize.yml
```
9.  Apply Job manifest
```
kubectl apply -f ./job.yml
```
10. Apply Sleep manifest
```
kubectl apply -f ./sleep.yml
```
11. Apply InitContainers manifest
```
kubectl apply -f ./init.yml
```
You can see the result in the logs in `OpenLens`
or by using the command `kubectl logs -c [container_name] [pod_name]` <br>
To see the result in `OpenLens` do the next steps: <br>
12. Open `OpenLens` and connect to the `demo-cluster`<br>
13. Go to the pods and select `demo` namespace<br>
14. In the `pods` section you will have 4 pods. To see results of their work, open the logs for each pod<br>
15. Expected result: `Reader` containers should display `Hello Wolrld !!!` <br>

After execute clean up<br>
16.  Delete manifests
```
kubectl delete -f ./init.yml
```
```
kubectl delete -f ./dockerize.yml 
```
```
kubectl delete -f ./sleep.yml 
```
```
kubectl delete -f ./job.yml
```
17. Delete cluster
```
k3d cluster delete demo-cluster
```
18. Clean the system
```
docker system prune -f -a 
```


# References
1. [Dockerfile](https://docs.docker.com/engine/reference/builder/)
2. [Docker build](https://docs.docker.com/engine/reference/commandline/build/)
3. [Docker images](https://docs.docker.com/engine/reference/commandline/images/)
4. [Docker Hub image library](https://hub.docker.com/)
5. [Kubernetes](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#logs)
6. [Dockerize](https://github.com/jwilder/dockerize)
7. [Jobs](https://kubernetes.io/docs/concepts/workloads/controllers/job/)
8. [InitContainers](https://kubernetes.io/docs/concepts/workloads/pods/init-containers/)

