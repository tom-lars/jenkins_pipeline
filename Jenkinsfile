pipeline {
    agent any
    
    environment {
        // Define any environment variables you need
        ANSIBLE_CONFIG = "${WORKSPACE}/ansible/ansible.cfg"
        ANSIBLE_INVENTORY = "${WORKSPACE}/ansible/inventory"
        JENKINS_PLAYBOOK = "${WORKSPACE}/playbooks/jenkins-playbook.yml"
        BUILD_PLAYBOOK = "${WORKSPACE}/playbooks/build-playbook.yml"
        DEPLOY_PLAYBOOK = "${WORKSPACE}/playbooks/deploy-playbook.yml"
        
    }

    stages {
        stage('Pushing the Dockerfile on Build server') {
            steps {
                ansiblePlaybook(
                    playbook: "${env.JENKINS_PLAYBOOK}",
                    inventory: "${env.ANSIBLE_INVENTORY}",
                    credentialsId: 'ansible-ssh-key-id', // Jenkins credentials ID
                    extraVars: [
                        dockerfile_path: "${env.WORKSPACE}/Dockerfile",
                        destination_path: "/opt/"
                    ],
                    colorized: true
                )
            }
        }
        
        stage('Build and Push Image') {
            steps {
                ansiblePlaybook(
                    playbook: "${env.BUILD_PLAYBOOK}",
                    inventory: "${env.ANSIBLE_INVENTORY}",
                    credentialsId: 'ansible-ssh-key-id', // Jenkins credentials ID
                    extraVars: [
                        BUILD_ID = "${env.BUILD_ID}",
											  JOB_NAME = "${env.JOB_NAME}",
		                    docker_hub_account = ""
                    ],
                    colorized: true
                
            }
        }
        
        stage('Deploy Container on Deploy Server') {
            steps {
                ansiblePlaybook(
                    playbook: "${env.DEPLOY_PLAYBOOK}",
                    inventory: "${env.ANSIBLE_INVENTORY}",
                    credentialsId: 'ansible-ssh-key-id', // Jenkins credentials ID
                    extraVars: [
                        JOB_NAME: "${env.JOB_NAME}",
                        docker_hub_account: "",
                        container_name: "web100"
                    ],
                    colorized: true
                
            }
        }
    }
}
