//docker
//kubectl
//gcloud
pipeline {
    agent any
    environment {
        git_repo = "https://github.com/Filip3Kx/node-app-kubernetes"
        git_branch = "dev"
        registry_url = "europe-west1-docker.pkg.dev"
        registry_path = "/node-app-399813/node-app/"
    }
    stages{
        stage("Clone repo to local") {
            steps{
                git branch: "${git_branch}", url: "${git_repo}"
            }
        }
        stage("Run unit tests") {
            steps {
                sh 'docker compose up -d'
                sh 'sleep 10'
                sh 'docker compose exec node npm test > docker_test.txt' //run unit test on containers from compose
                //get logs
                sh 'docker compose logs > docker_logs.txt'
                sh 'docker compose down'
            }
        }
        stage("Push image to Artifact Registry") {
            steps {
                sh "gcloud auth print-access-token | docker login -u oauth2accesstoken --password-stdin https://${registry_url}"
                sh "docker tag node-app-node:latest ${registry_url}${registry_path}node-app-node:latest"
                sh "docker push ${registry_url}${registry_path}node-app-node:latest"
                
                sh "docker tag node-app-node:latest ${registry_url}${registry_path}node-app-node:${BUILD_ID}"
                sh "docker push ${registry_url}${registry_path}node-app-node:${BUILD_ID}"
                
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
                sh "docker rmi node-app-node"
                sh "docker rmi ${registry_url}${registry_path}node-app-node:latest"
                sh "docker rmi ${registry_url}${registry_path}node-app-node:${BUILD_ID}"
            }
        }
    }
}