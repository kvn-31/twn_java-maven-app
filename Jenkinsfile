pipeline {
    agent any

    tools {
        maven "maven-3.9"
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
                    env.IMAGE_NAME = "$version-$BUILD_NUMBER"
                }
            }
        }

        stage("build jar") {
            steps {
                script {
                    echo 'building the application...'
                    sh 'mvn clean package' // makes sure we always delete the target folder before building
                }
            }
        }

        stage("build image") {
            steps {
                script {
                    echo "building the docker image with name: ${IMAGE_NAME}..."
                    withCredentials([usernamePassword(credentialsId: 'docker-hub', passwordVariable: 'PASS', usernameVariable: 'USER')]) {
                        sh "docker build -t kvnvna/demo-app:${IMAGE_NAME} ."
                        sh 'echo $PASS | docker login -u $USER --password-stdin'
                        sh "docker push kvnvna/demo-app:${IMAGE_NAME}"
                    }
                }
            }
        }

        stage("deploy") {
            steps {
                script {
                    echo 'deploying the application...'
                }
            }
        }
    }
}
