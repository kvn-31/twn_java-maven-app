#!/usr/bin/env groovy
library identifier: 'jenkins-shared-library@master', retriever: modernSCM(
        [$class: 'GitSCMSource',
         remote: 'https://github.com/kvn-31/twn_jenkins-shared-library.git',
         credentialsId: 'github-credentials']
)

pipeline {
    agent any
    tools {
        maven "maven-3.9"
    }
    environment {
        IMAGE_NAME = 'kvnvna/demo-app'
        TAG = 'java-maven-aws-1.1'
    }

    stages {
        stage('build app') {
            steps {
                echo 'building application jar...'
                buildJar()
            }
        }
        stage('build image') {
            steps {
                script {
                    echo 'building the docker image...'
                    buildImage(env.IMAGE_NAME)
                    dockerLogin()
                    dockerPush(env.IMAGE_NAME)
                }
            }
        }
        stage("deploy") {
            steps {
                script {
                    echo 'deploying docker image to EC2...'
                    def shellCmd = "bash ./server-cmds.sh ${IMAGE_NAME} ${TAG}"
                    def ec2Instance = 'ec2-user@3.79.18.159'
                    sshagent(['ec2-server-key']) {
                        sh "scp docker-compose.yaml ${ec2Instance}:/home/ec2-user"
                        sh "scp server-cmds.sh ${ec2Instance}:/home/ec2-user"
                        sh "ssh -o StrictHostKeyChecking=no ${ec2Instance} ${shellCmd}"
                    }
                }
            }
        }
    }
}
