//docker
//kubectl
//gcloud
pipeline {
    agent any
    environment {
        git_repo = "dev"
        git_branch = "https://github.com/Filip3Kx/node-app-kubernetes"
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
            sh 'docker compose exec node npm test' //run unit test on containers from compose
            //get logs
            sh 'docker compose down'
        }
        stage("Build docker app image") {
            script {
                dockerImage = docker.build registry + ":$BUILD_NUMBER"
            }
        }
        stage("Push image to Artifact Registry") {
            script {
                docker.withRegistry( '', registryCredential ) {
                dockerImage.push()
                }
            }
        }
        stage("Deploy to GKE cluster") {
            steps{
                //login to cluster
                //change image on app object
                //kubectl describe to logs
            }
        }
        stage("Upload logs to GCS Bucket") {
            steps{
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