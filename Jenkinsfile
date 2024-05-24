pipeline {
    agent any
    environment {
        DOCKER_HUB_USER = 's5carles'
        IMAGE = 's5carles/let-do-it'
        TAG = '0.1'
    }
    parameters {
        string(name: 'BRANCH', defaultValue: 'main', description: 'Branch to build')
        string(name: 'PORT', defaultValue: '7000', description: 'Port to expose')
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
                withCredentials([string(credentialsId: 'carles-docker-hub', variable: 'DOCKER_HUB_PASSWORD')]) {
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
    }
    post {
        always {
            script {
                // Clean-up steps
                def containerId = sh(script: "docker ps -q --filter ancestor=${IMAGE}:${TAG}", returnStdout: true).trim()
                if (containerId) {
                    sh "docker stop ${containerId}"
                    sh "docker rm ${containerId}"
                }
            }
        }
    }
}
