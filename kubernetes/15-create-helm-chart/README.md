# Task
In k3d create a helm chart using a [spring-boot](https://github.com/Alliedium/springboot-api-rest-example) application, [postgresql](https://www.postgresqltutorial.com/postgresql-getting-started/what-is-postgresql/), and [pgadmin](https://www.pgadmin.org/). Check if data are still available after deleting the helm chart and reinstalling it.

# Prerequisites

- Follow prerequisites steps 1-5 from [README.md](../../README.md)

- Copy `springboot-api-rest-example` submodule to your working directory 
```
cp -r $HOME/training-devops-aiudina/submodules/springboot-api-rest-example ~/training-devops-aiudina/kubernetes/15-create-helm-chart
```

    
# How to run 

1. Create kubernetes cluster named `demo-cluster-1` with local container registry named `demo-registry`:
```
k3d cluster create demo-cluster-1 --registry-create demo-registry:12345
```
2. Create a new namespace in the current context cluster
```
kubectl create namespace demo
```
3. Switch to the `demo` namespace 
```
kubectl ns demo
```
If `ns` is not installed on yourmachine, use the command below:
```shell
kubectl config set-context --current --namespace `demo`
```
Need to build an image for spring-boot app.

4. Go to the necessary folder with spring-boot application
```
cd ~/training-devops-aiudina/kubernetes/15-create-helm-chart/springboot-api-rest-example/api
```

5. Build Dockerfile
```
docker build -f ./docker/Dockerfile.prod -t spring-boot-app:0.1 .
```
6. Add a tag to the image for pushing it to the local container registry
```
docker tag spring-boot-app:0.1 localhost:12345/spring-boot-app:0.1
```

7.  Push the image to the local container registry
```
docker push localhost:12345/spring-boot-app:0.1
```
8. Go to the necessary folder with the helm chart 
```
cd $HOME/training-devops-aiudina/kubernetes/15-create-helm-chart
```
9.  Install helm chart `my-chart`
```
helm upgrade --install --cleanup-on-fail my-chart ./my-chart --namespace test --create-namespace --set service.type=LoadBalancer --wait
```
10. Forward the host ports by spring-boot and pgadmin to the ports, which are listening by the services
- pgadmin
```
k3d cluster edit demo-cluster-1 --port-add 18999:8099@loadbalancer
```
- spring boot 
```
k3d cluster edit demo-cluster-1 --port-add 16999:8080@loadbalancer
```
11.  Go to the browser and open <br>
- pgadmin
```
http://localhost:18999
```
- spring boot 
```
http://localhost:16999
```

12. On `spring-boot` window click on `sign up` button to register new user with random registered data
13. After registering a new user, go to `pgadmin` site and `log in`. To log in on `pgadmin` use [PGADMIN_DEFAULT_EMAIL](./my-chart/templates/pgadmin-statefulset.yaml) and password from [secret.yml](./my-chart/templates/secret.yaml).
14. After logging create a new server - click on `Add New Server`. Fill in the data in the `general` (only `name` field) and `connection` windows- use data from [secret.yml](./my-chart/templates/secret.yaml) and [config.yml](./my-chart/templates/config.yaml).
15. To check created service and new user, click on the left on the `Servers` -> `test` -> `Databases` -> `check-db` -> `Schemas` -> `Tables` -> `User(right click)` -> `View/Edit Data` -> `All rows`.

16. Check if data are still available after deleting the helm chart and reinstalling it.

```
helm uninstall my-chart -n test
```
```
helm upgrade --install --cleanup-on-fail my-chart ./my-chart --namespace test --create-namespace --set service.type=LoadBalancer --wait
```
And after that, you need to refresh the pgadmin window in the browser. Log in again and check the data. 

17. Delete the helm chart and clean the system 
```
helm uninstall my-chart -n test
```
```
docker rmi spring-boot-app:0.1
```
```
k3d cluster delete demo-cluster-1
```
```
docker system prune -f -a
```

# References
1. [Dockerfile](https://docs.docker.com/engine/reference/builder/)
2. [Docker build](https://docs.docker.com/engine/reference/commandline/build/)
3. [Docker images](https://docs.docker.com/engine/reference/commandline/images/)
4. [Docker Hub image library](https://hub.docker.com/)
5. [Kubernetes](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#logs)
6. [PostgreSQL](https://www.postgresqltutorial.com/postgresql-getting-started/what-is-postgresql/)
7. [PGadmin](https://www.pgadmin.org/)
8. [Helm Chart](https://www.freecodecamp.org/news/what-is-a-helm-chart-tutorial-for-kubernetes-beginners/)


