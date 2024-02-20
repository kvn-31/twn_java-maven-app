def gv

pipeline {
    agent any

    tools {
        maven "maven-3.9"
    }

//    parameters {
//        string(name: 'PARAM_BUILD_VERSION', defaultValue: '1.0.0', description: 'Version of the build')
//        booleanParam(name: 'executeTests', defaultValue: true, description: 'Execute tests')
//    }

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
                    gv.buildJar()

                }
            }
        }

        stage("build image") {
            steps {
                script {
                    gv.buildImage()
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
