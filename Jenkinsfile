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
        IMAGE_NAME = 'kvnvna/demo-app:java-maven-2.0'
    }

    stages {
        stage('destroy old tf setup') {
            steps {
                script {
                    dir('terraform') {
                        sh 'terraform destroy -auto-approve'
                    }
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
                    dockerLogin() // docker login on Jenkins Server
                    buildImage("${env.IMAGE_NAME}")
                    dockerPush("${env.IMAGE_NAME}")
                }
            }
        }
        stage("provision server") {
            environment {
                AWS_ACCESS_KEY_ID = credentials('jenkins_aws_access_key_id')
                AWS_SECRET_ACCESS_KEY = credentials('jenkins_aws_secret_access_key')
                TF_VAR_env_prefix = 'test'
            }
            steps {
                script {
                    dir('terraform') {
                        sh 'terraform init'
                        sh 'terraform apply -auto-approve'
                        EC2_PUBLIC_IP = sh(
                                script: "terraform output ec2_public_ip",
                                returnStdout: true
                        ).trim()

                    }

                }
            }
        }

        stage("deploy") {
            // needed for docker login on EC2 server
            environment {
                DOCKER_CREDS = credentials('docker-hub')
            }

            steps {
                script {
                    echo "waiting for EC2 server to initialize"
                    sleep(time: 90, unit: "SECONDS")

                    echo 'deploying docker image to EC2...'
                    echo "${EC2_PUBLIC_IP}"

                    //  DOCKER_CREDS_USR and DOCKER_CREDS_PSW are variables that are automatically created by Jenkins (USR & PSW)
                    def shellCmd = "bash ./server-cmds.sh ${IMAGE_NAME} ${DOCKER_CREDS_USR} ${DOCKER_CREDS_PSW}"
                    def ec2Instance = "ec2-user@${EC2_PUBLIC_IP}"

                    sshagent(['server-ssh-key']) {
                        sh "scp -o StrictHostKeyChecking=no server-cmds.sh ${ec2Instance}:/home/ec2-user"
                        sh "scp -o StrictHostKeyChecking=no docker-compose.yaml ${ec2Instance}:/home/ec2-user"
                        sh "ssh -o StrictHostKeyChecking=no ${ec2Instance} ${shellCmd}"

                    }
                }
            }
        }
    }
}
