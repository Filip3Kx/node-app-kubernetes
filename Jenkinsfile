//docker
//kubectl
//gcloud
pipeline {
    agent any
    environment {
        git_repo = "https://github.com/Filip3Kx/node-app-kubernetes"
        git_branch = "dev"
        registry_name = "tobedone"
        registry_credential = 'artifact_registry'
    }
    stages{
        stage("Clone repo to local") {
            steps{
                git branch: "${git_branch}", url: "${git_repo}"
            }
        }
        stage("Run unit tests") {
            steps {
                sh 'docker compose up'
                sh 'docker compose exec node npm test' //run unit test on containers from compose
                //get logs
                sh 'docker compose logs > docker_test.txt'
                sh 'docker compose down'
            }
        }
        stage("Build docker app image") {
            steps {
                script {
                    dockerImage = docker.build registry + ":$BUILD_NUMBER"
                }    
            }   
        }
        stage("Push image to Artifact Registry") {
            steps {
                script {
                    docker.withRegistry( '', registryCredential ) {
                    dockerImage.push()
                }
            }    
            }
        }
        stage("Deploy to GKE cluster") {
            steps{
                sh "echo Deploying"
                //login to cluster
                //change image on app object
                //kubectl describe to logs
            }
        }
        stage("Upload logs to GCS Bucket") {
            steps{
                sh "echo Uploading"
                //GCS Upload
            }
        }
        stage("Cleanup") {
            steps{
                sh "docker rmi $registry:$BUILD_NUMBER"
            }
        }
    }
}