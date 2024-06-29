pipeline {
  agent any

  stages {
    stage ('git clone') {
      steps {
        echo 'cloning repo'
        git branch: 'main', url: 'https://github.com/Angecalais97/let-do-it.git'
      }
    }

    stage ('build and deploy') {
      steps {
        echo 'building docker image'
        sh '''
        docker build -t s7 .
        docker images
        docker tag s7 s5carles/docker-image:0.0
        docker images
        docker run -d -p 5000:80 s5carles/docker-image:0.0
        docker ps
        '''
      }
    }

    stage ('login to docker hub and push the image') {
      steps {
        echo 'loging to docker hub'
        sh '''
        docker login -u s5carles -p dckr_pat_7Oi5rpg88Br5X8jkGFCDu8DzBtM
        echo 'pushing to docker hub'
        docker push s5carles/docker-image:0.0
        '''
      }
    }
  }
}
