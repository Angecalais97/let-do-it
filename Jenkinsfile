pipeline {
  agent any
  environment {
    DOCKER_IMAGE = "s5carles/do-it"
  }
  parameters {
    string(defaultValue: 'main', description: 'branch to build', name: 'BRANCH')
    string(defaultValue: '', description: 'port to expose', name: 'PORT')
    string(defaultValue: 'your-namespace', description: 'Kubernetes namespace to clean', name: 'NAMESPACE')
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
        sh '''#!/bin/bash
        docker build -t ${DOCKER_IMAGE}:${BUILD_NUMBER} .
        docker images
        docker run -d -p ${PORT}:80 ${DOCKER_IMAGE}:${BUILD_NUMBER}
        docker ps
        '''
      }
    }

    stage('login AND PUSH to docker hub') {
      steps {
        withCredentials([string(credentialsId: 'docker-bub-cred', variable: 'DOCKERHUB_CREDENTIAL')]) {
          sh '''#!/bin/bash
            docker login -u s5carles -p "${DOCKERHUB_CREDENTIAL}"
            docker push "${DOCKER_IMAGE}:${BUILD_NUMBER}"
          '''
        }
      }
    }
    
    stage('deploy to k8s') {
      steps {
        withKubeConfig([credentialsId: 'kubeconfig-cred']) {
          sh '''#!/bin/bash
          kubectl apply -f path/to/your/deployment.yaml
          kubectl apply -f path/to/your/service.yaml
          '''
        }
      }
    }

    stage('clean namespace') {
      steps {
        withKubeConfig([credentialsId: 'kubeconfig-cred']) {
          sh '''#!/bin/bash
          kubectl delete all --all -n ${params.NAMESPACE}
          '''
        }
      }
    }
  }
}
