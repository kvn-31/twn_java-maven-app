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

        stage("commit version update") {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'github-credentials', passwordVariable: 'PASS', usernameVariable: 'USER')]) {
                        sh 'git config --global user.email "jenkins@example.com"'
                        sh 'git config --global user.name "jenkins"'

                        sh 'git status'
                        sh 'git branch'
                        sh 'git config --list'

                        sh "git remote set-url origin https://${USER}:${PASS}@github.com/kvn-31/twn_java-maven-app.git"
                        sh 'git add pom.xml'
                        sh 'git commit -m "incrementing app version"'
                        sh 'git push origin HEAD:increment-app-version'
                    }
                }
            }
        }
    }
}
