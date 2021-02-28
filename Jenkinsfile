pipeline {
    agent any

    stages {
        stage ('Initialize') {
            steps {
                sh 'checkov --directory . -o junitxml > result.xml || true'
                junit "result.xml"
            }
        }
    }
}