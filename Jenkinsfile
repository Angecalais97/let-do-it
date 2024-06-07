pipeline {
    agent any
    
    environment {
        DOCKER_HUB_USER = 's5carles'
        IMAGE = 's5carles/let-do-it'
        TAG = '0.1'
    }
    
    parameters {
        string(name: 'BRANCH', defaultValue: '', description: 'Branch to build')
        string(name: 'PORT', defaultValue: '', description: 'Port to expose')
        booleanParam description: 'building job', name: 'true'
        choice choices: ['douala', 'yde', 'baf', 'limbe ', 'buea'], name: 'town'
    }
    
    stages {
        stage('Checkout') {
            steps {
                script {
                    git branch: "${params.BRANCH}", url: 'https://github.com/Angecalais97/let-do-it'
                }
            }
        }

        stage('Login to Docker Hub') {
            steps {
                withCredentials([string(credentialsId: 'docke-hub-cred', variable: 'DOCKER_HUB_PASSWORD')]) {
                    sh 'docker login -u ${DOCKER_HUB_USER} -p ${DOCKER_HUB_PASSWORD}'
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                sh '''
                docker build -t ${IMAGE}:${TAG} .
                docker images
                '''
            }
        }
        
        

        stage('Run Docker Image') {
            steps {
                script {
                    def port = params.PORT
                    sh """
                    docker run -d -p ${port}:80 ${IMAGE}:${TAG}
                    docker ps
                    """
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                sh 'docker push ${IMAGE}:${TAG}'
            }
        }

        stage('Notify via Slack') {
            steps {
                slackSend channel: 'jenkins-notification-ars', 
                    color: 'good', 
                    message: 'Build and deployment completed successfully.', 
                    teamDomain: 'Devops-easy-learning', 
                    tokenCredentialId: 'slack-cred'
            }
        }
    }
}
