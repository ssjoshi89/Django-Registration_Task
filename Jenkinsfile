pipeline {
    agent any
    
    environment {
        ANSIBLE_CONFIG='/var/lib/jenkins/workspace/ansible/ansible.cfg'
        ANSIBLE_KEY = '/mnt/mykey.pem'
    }

    stages {
        stage('Terraform Building Infrastructure') {
            steps {
                dir('terraform') {
                    sh 'terraform init'
                    sh 'terraform apply -auto-approve'
                    sh 'terraform output | grep -E -o "([0-9]{1,3}[\\.]){3}[0-9]{1,3}" >> ../ansible/hosts'
                    sh 'sleep 20'
                }
                echo 'Done!'
            }
        }

        stage('Ansible Config Servers') {
            steps {
                dir('ansible') {
                    sh 'cat hosts'
                    sh 'ansible -i hosts all --private-key $ANSIBLE_KEY -m ping'
                    sh 'ansible-playbook -i hosts --private-key $ANSIBLE_KEY servcfg.yml'
                }
                echo 'Done!'
            }
        }

        stage('Deploying App') {
            steps {
                dir('ansible') {
                    sh 'echo "DEBUG = False" >> ../Django-Registration_Task/Django_Registration/settings.py'
                    sh 'ansible-playbook -i hosts --private-key $ANSIBLE_KEY push_app.yml'
                }
                echo 'Done!'
            }
        }


        
    }

}

