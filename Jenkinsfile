pipeline {
    agent any

    stages {
        stage('Install Dependencies') {
            steps {
                sh 'npm install -g newman newman-reporter-html'
            }
        }

        stage('Run Postman Tests') {
            steps {
                sh 'newman run Admin.postman_collection.json -e MyEnvironment.json -r cli,html --reporter-html-export newman-report.html'
            }
        }

        stage('Publish Report') {
            steps {
                publishHTML(target: [
                    reportName : 'Postman API Test Report',
                    reportDir  : '.',
                    reportFiles: 'newman-report.html',
                    keepAll    : true
                ])
            }
        }
    }
}
