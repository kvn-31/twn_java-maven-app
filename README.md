Based on [TWN - Java Maven App - Jenkins Files](https://gitlab.com/twn-devops-bootcamp/latest/08-jenkins/java-maven-app)

Used for Demo purposes

This repository contains setup using Jenkins that:

- Builds the app
- Creates a Docker image
- Pushes the Docker image to a private Docker registry
- Integrates Terraform to provision a remote server
  - Create SSH key pair
  - Install Terraform inside Jenkins container
  - create TF config to provision the server

For an overview of the available branches check the README.md of the master branch.

## Prerequisites
- create credentials in Jenkins
- install Terraform inside Jenkins container
