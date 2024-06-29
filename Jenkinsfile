pipeline {
  agent any

  stages {
    stage ('git clone') {
      steps {
        echo 'cloning repo'
        git branch: 'main', url: 'https://github.com/Angecalais97/let-do-it.git'
      }
    }
  }
}
