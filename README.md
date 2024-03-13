Based on [TWN - Java Maven App - Jenkins Files](https://gitlab.com/twn-devops-bootcamp/latest/08-jenkins/java-maven-app)

Used for Demo purposes

This repository contains setup using Jenkins that:

- Builds the app
- Creates a Docker image
- Pushes the Docker image to a private Docker registry
- Deploys the app to a k8s cluster

Have a look at the following branches:

- `master` & `develop` - were used to setup Freestyle & Pipeline Jobs
- `jenkins-shared-lib` - used to achieve the same setup using a Jenkins Shared Library
- `increment-app-version` - an extension which increments the app version on every build and commits the changes back to the repository
- `aws-deployment` - an extension which deploys the app on an AWS EC2 instance using ssh
- `aws-deployment-docker-compose` - deploys the app using Docker Compose; increments the app version on every build and commits the changes back to the repository
- `deploy-on-k8s` - deploys nginx (for testing purposes) to a k8s cluster in the deploy step
- `build-and-deploy-k8s` - builds the app and deploys it to a k8s cluster

## Prerequisites
- k8s cluster (in this case aws eks)
- in order to have this running, we need to authenticate with the cluster
```bash
kubectl create secret docker-registry my-registry-key \  #the name of the secret can be anything, but needs to be referenced in the deployment file
  --docker-server=docker.io \
  --docker-username=USER \
  --docker-password=PASSWORD #the password might be needed to be escaped using single quotes
```
- the step above can also be covered with simple check in the Jenkinsfile (if secret exists skip, if not create)

## Branch specific details
- added kubernetes folder containing a deployment and a service file
- added deployment step in Jenkinsfile which deploys the app to a k8s cluster
