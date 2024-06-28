def gv

pipeline {
    agent any

    tools {
        maven "maven-3.9"
    }

    environment {
        ANSIBLE_SERVER = "104.248.137.33"
    }


    stages {
        stage("copy files to ansible server") {
            steps {
                script {
                    echo "copying all necessary files to ansible server..."
                    sshagent(['ansible-server-key']) {
                        sh 'scp -o StrictHostKeyChecking=no ansible/* root@${ANSIBLE_SERVER}:/root' // copy all jenkins files to the ansible server

                        withCredentials([sshUserPrivateKey(credentialsId: 'ec2-server-key', keyFileVariable: 'keyfile', usernameVariable: 'user')]) {
                            sh 'scp $keyfile root@$ANSIBLE_SERVER:/root/ssh-key.pem'
                        }
                    }
                }
            }
        }
    }
}
