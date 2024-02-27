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
        stage("increment version") {
            steps {
                script {
                    echo 'incrementing the app version...'
                    sh 'mvn build-helper:parse-version versions:set \
                    -DnewVersion=\\\${parsedVersion.majorVersion}.\\\${parsedVersion.minorVersion}.\\\${parsedVersion.nextIncrementalVersion} \
                    versions:commit'
                    def matcher = readFile('pom.xml') =~ '<version>(.+)</version>'
                    def version = matcher[0][1]
                    env.TAG = "$version-$BUILD_NUMBER"
                }
            }
        }

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
                    buildImage("${env.IMAGE_NAME}:${env.TAG}")
                    dockerLogin()
                    dockerPush("${env.IMAGE_NAME}:${env.TAG}")
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

        stage("commit version update") {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'github-access-token-push', passwordVariable: 'PASS', usernameVariable: 'USER')]) {
                        sh 'git config --global user.email "jenkins@example.com"'
                        sh 'git config --global user.name "jenkins"'

                        sh "git remote set-url origin https://${USER}:${PASS}@github.com/kvn-31/twn_java-maven-app.git"
                        sh 'git add pom.xml'
                        sh 'git commit -m "ci: increment app version"'
                        sh "git push origin HEAD:${GIT_BRANCH}"
                    }
                }
            }
        }
    }
}
