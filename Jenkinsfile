pipeline {
  agent any
  environment {
    DOCKER_IMAGE = "s5carles/do-it"
  }
  parameters {
    string(defaultValue: 'main', description: 'branch to build', name: 'BRANCH')
    string(defaultValue: '', description: 'port to expose', name: 'PORT')
  }
  stages {
    stage('clone repo') {
      steps {
        git branch: "${params.BRANCH}", url: 'https://github.com/Angecalais97/let-do-it/'
        sh 'ls -ltr'
      }
    }

    stage('build image and test') {
      steps {
        sh '''
          #!/bin/bash
          docker build -t ${env.DOCKER_IMAGE}:${BUILD_NUMBER} .
          docker images
          docker run -d -p ${params.PORT}:80 ${env.DOCKER_IMAGE}:${BUILD_NUMBER}
          docker ps
        '''
      }
    }

    stage('login AND PUSH to docker hub') {
      steps {
        withCredentials([string(credentialsId: 'docker-bub-cred', variable: 'DOCKERHUB_CREDENTIAL')]) {
          sh '''
            docker login -u s5carles -p "${DOCKERHUB_CREDENTIAL}"
            docker push "${env.DOCKER_IMAGE}:${BUILD_NUMBER}"
          '''
        }
      }
    }
  }
}
