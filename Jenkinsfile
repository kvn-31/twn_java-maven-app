#!/usr/bin/env groovy
library identifier: 'jenkins-shared-library@master', retriever: modernSCM(
  [$class: 'GitSCMSource',
   remote: 'https://github.com/kvn-31/twn_jenkins-shared-library.git',
   credentialsId: 'github-credentials']
)
def gv

pipeline {
    agent any

    tools {
        maven "maven-3.9"
    }

    stages {
        stage('Init') {
            steps {
                script {
                    gv = load "script.groovy"
                }
            }
        }
        stage("build jar") {
            steps {
                script {
                    buildJar()
                }
            }
        }

        stage("build and push image") {
            steps {
                script {
                    buildImage('kvnvna/demo-app:jma-3.0')
                    dockerLogin()
                    dockerPush('kvnvna/demo-app:jma-3.0')
                }
            }
        }

        stage("deploy") {
            steps {
                script {
                    gv.deployApp()
                }
            }
        }
    }
}
