pipeline {
    agent any

    environment {
        AWS_ACCOUNT_ID="191856567065"
        AWS_DEFAULT_REGION="us-east-1" 
	CLUSTER_NAME="demo"
	SERVICE_NAME="demo-service"
	TASK_DEFINITION_NAME="my-demo-task"
	DESIRED_COUNT="1"
        IMAGE_REPO_NAME="demo"
        IMAGE_TAG="latest"
        REPOSITORY_URI = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}"
	registryCredential = "safwan.kurawlay"
    }

    stages {
        stage('Docker image setup') {
            steps {
		    sh "docker build --no-cache --build-arg \"ENV=test\" --tag \"${IMAGE_REPO_NAME}:${IMAGE_TAG}\" ."
            }
        }
 	 
	stage('Pushing to ECR') {
    		 steps{  
        		 script {
			 docker.withRegistry("https://" + REPOSITORY_URI, "ecr:${AWS_DEFAULT_REGION}:" + registryCredential) {
                    	 sh "docker tag demo:latest 191856567065.dkr.ecr.us-east-1.amazonaws.com/demo:latest"
			 sh "docker push 191856567065.dkr.ecr.us-east-1.amazonaws.com/demo:latest "
			 sh "docker rmi 191856567065.dkr.ecr.us-east-1.amazonaws.com/demo:latest"
			 sh "docker rmi demo:latest"
                	}
        	 }
        }
      }
	    
	    
	stage('Deploy') {
     steps{
            withAWS(credentials: registryCredential, region: "${AWS_DEFAULT_REGION}") {
                script {
			 sh './script.sh'
                }
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
