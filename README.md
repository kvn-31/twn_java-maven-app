Based on [TWN - Java Maven App - Jenkins Files](https://gitlab.com/twn-devops-bootcamp/latest/08-jenkins/java-maven-app)

Used for Demo purposes

# Run Ansible from Jenkins pipeline

## Droplets
Two droplets (one for Jenkins, one for Ansible Server) were created
- Ansible Server
    - ran `apt update` and `apt install ansible` to install ansible
    - `apt install python3-pip` to install pip
    - `apt install python3-boto3` to install globally or `pip3 install botocore boto3` to install in venv (needs to be created before)
    - verify installation `python3 -c "import boto3"` (should not throw an error)
    - in users home directory `mkdir .aws` and create `vim credentials` file with the following content:
      ```ini
      [default]
      aws_access_key_id = YOUR_ACCESS_KEY
      aws_secret_access_key = YOUR_SECRET_KEY
      ```
        - `chmod 600 credentials` to make the file only readable by the owner (did not do in the course)

## AWS EC2 Instances
This time manually created in management console (2 instances)
- Amazon Linux2
- t2.micro
- new key-pair

## Jenkins
- add the private SSH key that is stored in Digitalocean (public) to Jenkins (credentials - ssh username with private key)
- add the private key of the ec2 instances to Jenkins (credentials - ssh username with private key)
- see Java-Maven-App project feature/ansible for more details (such as Jenkinsfile)

