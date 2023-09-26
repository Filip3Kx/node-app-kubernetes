//docker
//kubectl
//gcloud
pipeline {
    agent any
    environment {
        git_repo = "https://github.com/Filip3Kx/node-app-kubernetes"
        git_branch = "dev"
        registry_url = "europe-west1-docker.pkg.dev"
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
                sh 'docker compose exec node npm test' //run unit test on containers from compose
                //get logs
                sh 'docker compose logs > docker_test.txt'
                sh 'docker compose down'
            }
        }
        stage("Push image to Artifact Registry") {
            steps {
                sh "gcloud auth print-access-token | docker login -u oauth2accesstoken --password-stdin https://europe-west1-docker.pkg.dev"
                sh "docker tag node-app-node:latest europe-west1-docker.pkg.dev/node-app-399813/node-app/node-app-node:latest"
                sh "docker push europe-west1-docker.pkg.dev/node-app-399813/node-app/node-app-node:latest"
                
                sh "docker tag node-app-node:latest europe-west1-docker.pkg.dev/node-app-399813/node-app/node-app-node:${BUILD_ID}"
                sh "docker push europe-west1-docker.pkg.dev/node-app-399813/node-app/node-app-node:${BUILD_ID}"
                
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
                sh "docker rmi europe-west1-docker.pkg.dev/node-app-399813/node-app/node-app-node:latest"
                sh "docker rmi europe-west1-docker.pkg.dev/node-app-399813/node-app/node-app-node:${BUILD_ID}"
            }
        }
    }
}