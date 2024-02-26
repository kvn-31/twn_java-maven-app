Based on [TWN - Java Maven App - Jenkins Files](https://gitlab.com/twn-devops-bootcamp/latest/08-jenkins/java-maven-app)

Used for Demo purposes

This repository contains setup using Jenkins that:

- Builds the app
- Creates a Docker image
- Pushes the Docker image to a private Docker registry

Have a look at the following branches:

- `master` & `develop` - were used to setup Freestyle & Pipeline Jobs
- `jenkins-shared-lib` - used to achieve the same setup using a Jenkins Shared Library
- `increment-app-version` - an extension which increments the app version on every build and commits the changes back to the repository
- `aws-deployment` - an extension which deploys the app on an AWS EC2 instance using ssh
