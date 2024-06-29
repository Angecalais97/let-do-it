pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "s5carles/docker-image"
        DOCKERHUB_CREDENTIAL = credentials('docker-bub-cred')
    }

    parameters {
        string(defaultValue: 'main', description: 'Branch to build', name: 'BRANCH')
        string(defaultValue: '4000', description: 'Port to expose', name: 'PORT')
    }

    stages {
        stage('git clone') {
            steps {
                echo 'Cloning repo'
                git branch: "${params.BRANCH}", url: 'https://github.com/Angecalais97/let-do-it.git'
            }
        }

        stage('build and deploy') {
            steps {
                echo 'Building Docker image'
                sh '''
                docker build -t s7 .
                docker images
                docker tag s7 ${env.DOCKER_IMAGE}:${BUILD_NUMBER}
                docker images
                docker run -d -p ${params.PORT}:80 ${env.DOCKER_IMAGE}:${BUILD_NUMBER}
                docker ps
                '''
            }
        }

        stage('login to docker hub and push the image') {
            steps {
                echo 'Logging in to Docker Hub'
                withCredentials([string(credentialsId: 'docker-bub-cred', variable: 'DOCKERHUB_CREDENTIAL')]) {
                    sh '''
                    docker login -u s5carles -p "${DOCKERHUB_CREDENTIAL}"
                    echo 'Pushing to Docker Hub'
                    docker push ${env.DOCKER_IMAGE}:${BUILD_NUMBER}
                    '''
                }
            }
        }
    }
}
