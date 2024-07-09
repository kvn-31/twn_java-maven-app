Based on [TWN - Java Maven App - Jenkins Files](https://gitlab.com/twn-devops-bootcamp/latest/08-jenkins/java-maven-app)

Used for Demo purposes

This repository contains setup using Jenkins that:

- Builds the app
- Creates a Docker image
- Pushes the Docker image to a private Docker registry
- Deploys the app to a k8s cluster

For an overview of all different branches in this repo have a look at the [master branch readme](https://github.com/kvn-31/twn_java-maven-app)

## Prerequisites
- k8s cluster (in this case aws eks)
- ecr repository
- in order to have this running, we need to authenticate with ECR
```bash
kubectl create secret docker-registry aws-registry-key \  #the name of the secret can be anything, but needs to be referenced in the deployment file
  --docker-server=REPO_URL \
  --docker-username=USER \
  --docker-password=PASSWORD
```
- the step above can also be covered with simple check in the Jenkinsfile (if secret exists skip, if not create)

## Branch specific details
- added kubernetes folder containing a deployment and a service file
- added deployment step in Jenkinsfile which deploys the app to a k8s cluster
- confirm the deployment with `kubectl get all` / describe the pods
