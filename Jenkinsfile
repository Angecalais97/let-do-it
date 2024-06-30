pipeline {
  agent any
  stages {
    stage ('clone repo') {
      steps {
        git branch: 'main', url: 'https://github.com/Angecalais97/let-do-it/'
        sh 'ls -ltr'
      }
    }

    stage ('build image and test') {
      steps {
        sh '''
        docker build -t s5carles/do-it:01 .
        docker images
        docker run -d -p 2000:80 s5carles/do-it:01
        docker ps 
        '''
      }
    }

    stage ('login AND PUSH to docker hub') {
      steps {
          withCredentials([string(credentialsId: 'docker-bub-cred', variable: 'DOCKERHUB_CREDENTIAL')]) {
            sh '''
            docker login -u s5carles -p "${DOCKERHUB_CREDENTIAL}"
            docker push s5carles/do-it:01
            '''
          }
      }
    }
  }
}
