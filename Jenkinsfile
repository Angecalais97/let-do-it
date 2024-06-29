pipeline {
  agent any
  environment {
    DOCKER_IMAGE = "s5carles/docker-image"
    DOCKERHUB_CREDENTIAL = "docker-bub-cred"
}
  parameters {
    string defaultValue: 'main', name: 'BRANCH'
    string defaultValue: '4000', name: 'PORT'
}

  stages {
    stage ('git clone') {
      steps {
        echo 'cloning repo'
        git branch: '${params.BRANCH}', url: 'https://github.com/Angecalais97/let-do-it.git'
      }
    }

    stage ('build and deploy') {
      steps {
        echo 'building docker image'
        sh '''
        docker build -t s7 .
        docker images
        docker tag s7 ${env.DOCKER_IMAGE}:$BUILD_NUMBER
        docker images
        docker run -d -p ${params.PORT}:80 ${env.DOCKER_IMAGE}:$BUILD_NUMBER
        docker ps
        '''
      }
    }

    stage ('login to docker hub and push the image') {
      steps {
        echo 'loging to docker hub'
        sh '''
        docker login -u s5carles -p ${env.DOCKERHUB-CREDENTIAL}
        echo 'pushing to docker hub'
        docker push ${env.DOCKER_IMAGE}:$BUILD_NUMBER
        env
        '''
      }
    }
  }
}
