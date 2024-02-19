def gv

pipeline {
    agent any

    tools {
        maven "maven-3.9"
    }

    parameters {
        string(name: 'PARAM_BUILD_VERSION', defaultValue: '1.0.0', description: 'Version of the build')
        booleanParam(name: 'executeTests', defaultValue: true, description: 'Execute tests')
    }

    stages {
        stage('Init') {
            steps {
                script {
                    gv = load "script.groovy"
                }
            }
        }
        stage('Build') {
            steps {
                script {
                    gv.buildJar()
                }
            }
        }
        stage('Test') {
            when {
                expression {
                    params.executeTests
                }
            }
            steps {
                echo 'Testing..'
            }
        }
        stage('Deploy') {
            steps {
                echo "Deploying version ${PARAM_BUILD_VERSION}.."
                withCredentials([
                    usernamePassword(credentialsId: 'server-credentials', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')
                ]) {
                    echo "Deploying to server with ${USERNAME}:${PASSWORD}"
                }
            }
        }
    }
}
