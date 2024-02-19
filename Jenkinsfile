pipeline {
    agent any

    environment {
        BUILD_VERSION = '1.0.0'
        SERVER_CREDENTIALS = credentials('server-credentials')
    }

    tools {
        maven "maven-3.9"
    }

    parameters {
        string(name: 'BUILD_VERSION', defaultValue: '1.0.0', description: 'Version of the build')
        booleanParam(name: 'executeTests', defaultValue: true, description: 'Execute tests')
    }

    stages {
        stage('Build') {
            steps {
                echo 'Building..'
                echo "BUILD_VERSION=${BUILD_VERSION}"
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
                echo 'Deploying....'
                withCredentials([
                    usernamePassword(credentialsId: 'server-credentials', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')
                ]) {
                    echo "Deploying to server with ${USERNAME}:${PASSWORD}"
                }
            }
        }
    }
    post {
        always {
            echo 'This will always run'
        }
        success {
            echo 'This will run only if successful'
        }
        failure {
            echo 'This will run only if failed'
        }
        unstable {
            echo 'This will run only if the run was marked as unstable'
        }
        changed {
            echo 'This will run only if the state of the Pipeline has changed'
            echo 'For example, if the Pipeline was previously failing but is now successful'
        }
    }
}
