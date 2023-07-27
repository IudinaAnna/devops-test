# Task
In this task you should parametrize the helm chart that was created in task [K-15](../15-create-helm-chart). The difference between the parametrized helm chart and the normal one can be seen in the files in the folder [templates](./my-chart/templates/) from this task and in folder [templates]() from K-15 task. Check that the helm chart data remains after deleting and reinstalling. 

# Prerequisites

- Follow prerequisites steps 1-5 from [README.md](../../README.md)
- Copy `springboot-api-rest-example` submodule to your working directory 
```
cp -r $HOME/training-devops-aiudina/submodules/springboot-api-rest-example $HOME/training-devops-aiudina/kubernetes/16-parametrize-helm-chart
```
    
# How to run 

1. Create kubernetes cluster named `demo-cluster` with a local container registry named `demo-registry`:
```
k3d cluster create demo-cluster --registry-create demo-registry:12345 
```
2. Create a new namespace in the current context cluster
```
kubectl create namespace demo
```
3. Switch to the `demo` namespace 
```
kubectl ns demo
```
If `ns` is not installed on your machine, use below command:
```
kubectl config set-context --current --namespace 'demo'
```
Build an image for spring-boot app.

4. Go to the necessary folder with spring-boot application
```
cd $HOME/training-devops-aiudina/kubernetes/16-parametrize-helm-chart/springboot-api-rest-example/api
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
cd $HOME/training-devops-aiudina/kubernetes/16-parametrize-helm-chart
```
9.  Install helm chart `my-chart`
```
helm upgrade --install --cleanup-on-fail my-chart ./my-chart \
--namespace test\
--create-namespace \
--set service.type=LoadBalancer --wait
```
10. Forward the `spring-boot` and `pgadmin` host ports to the ports, which are listening by the services
- pgadmin
```
k3d cluster edit demo-cluster --port-add 12999:8099@loadbalancer
```
- spring boot
```
k3d cluster edit demo-cluster --port-add 13999:8080@loadbalancer
```
11.  Go to the browser and open `pgadmin` and `spring-boot`. <br>
- pgadmin
```
http://localhost:12999
```
- spring boot
```
http://localhost:13999
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
helm upgrade --install --cleanup-on-fail my-chart ./my-chart \
--namespace test\
 --create-namespace\
 --set service.type=LoadBalancer --wait
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
k3d cluster delete demo-cluster
```
```
docker system prune -f -a
```



# References
1. [Dockerfile](https://docs.docker.com/engine/reference/builder/)
2. [Docker build](https://docs.docker.com/engine/reference/commandline/build/)
3. [Docker images](https://docs.docker.com/engine/reference/commandline/images/)
4. [Docker Hub image library](https://hub.docker.com/)
5. [Helm Chart](https://www.freecodecamp.org/news/what-is-a-helm-chart-tutorial-for-kubernetes-beginners/)
6. [PostgreSQL](https://www.postgresqltutorial.com/postgresql-getting-started/what-is-postgresql/)
7. [PGadmin](https://www.pgadmin.org/)


