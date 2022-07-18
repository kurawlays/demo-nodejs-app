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
        IMAGE_TAG="${env.BUILD_NUMBER}"
        REPOSITORY_URI = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}"
	registryCredential = "safwan.kurawlay"
    }
   
    stages {

    // Tests
   /* stage('Unit Tests') {
      steps{
        script {
          sh 'npm install'
	  sh 'npm test -- --watchAll=false'
        }
      }
    }*/
        
    // Building Docker images
    stage('Building image') {
      steps{
        script {
	  echo "The build number is ${env.BUILD_NUMBER}"
	  git '…'
          def dockerImage = sudo docker.build "${IMAGE_REPO_NAME}:${IMAGE_TAG}" 
	//def dockerImage = sudo docker.build "demo:1" 
        }
      }
    }
	    
// hello
   
    // Uploading Docker images into AWS ECR
    stage('Pushing to ECR') {
     steps{  
         script {
			 docker.withRegistry("https://" + REPOSITORY_URI, "ecr:${AWS_DEFAULT_REGION}:" + registryCredential) {
                    	 dockerImage.push()
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
      
    }
}

