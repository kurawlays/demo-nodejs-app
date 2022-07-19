pipeline {
    agent any

    environment {
        SERVICE_NAME = 'order'
    }

    stages {
        stage('Docker image setup') {
            steps {
                sh "docker build --no-cache --build-arg \"ENV=test\" --tag \"${env.SERVICE_NAME}:${env.GIT_COMMIT}\" ."
            }
        }
     stage('Deploy') {
         steps{
                script {
			            sh './script.sh'
                }
         }
     }

      /*  stage('Lint tests') {
            steps {
                sh "docker run --rm --entrypoint pycodestyle ${env.SERVICE_NAME}:${env.GIT_COMMIT} /srv/tests /srv/order --verbose"
                sh "docker run --rm --entrypoint pylama ${env.SERVICE_NAME}:${env.GIT_COMMIT} /srv/tests /srv/order --verbose"
            }
        }*/
        

        // stage('Unit tests') {
        //     steps {
        //         sh "docker run --rm --entrypoint /srv/setup ${env.SERVICE_NAME}:${env.GIT_COMMIT} test"
        //     }
        // }
    }

  /*  post {
        success {
            script {
                new Deployer().deploy()
            }
        }
       

        always {
            script {
                sh "docker rmi ${env.SERVICE_NAME}:${env.GIT_COMMIT}"
            }
        } 
    }*/
}
