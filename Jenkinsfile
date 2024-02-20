#!/usr/bin/env groovy
@Library('jenkins-shared-library')
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

        stage("build image") {
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
