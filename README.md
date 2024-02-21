Based on [TWN - Java Maven App - Jenkins Files](https://gitlab.com/twn-devops-bootcamp/latest/08-jenkins/java-maven-app)

This repository contains a simple Java Maven App with a Jenkinsfile that:
- Builds the app
- Creates a Docker image
- Pushes the Docker image to a private Docker registry

In this project the App version is incremented automatically by the Jenkins pipeline.

A small part of the Jenkins output:
```bash
[Pipeline] sh
+ git add pom.xml
[Pipeline] sh
+ git commit -m ci: increment app version
[detached HEAD de85d6f] ci: increment app version
 1 file changed, 1 insertion(+), 1 deletion(-)
[Pipeline] sh
+ git push origin HEAD:increment-app-version
To https://github.com/kvn-31/twn_java-maven-app.git
   d492fc6..de85d6f  HEAD -> increment-app-version
```

The resulting commit by Jenkins is ignored using the [Jenkins Ignore Commit Plugin](https://plugins.jenkins.io/ignore-committer-strategy/).
