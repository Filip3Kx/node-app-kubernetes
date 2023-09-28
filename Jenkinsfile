pipeline {
    agent any
    environment {
        git_repo = "https://github.com/Filip3Kx/node-app-kubernetes"
        git_branch = "dev"
        registry_url = "europe-west1-docker.pkg.dev"
        registry_path = "/node-app-399813/node-app/"
        deployment_name = "deployment.apps/app-node-deployment"
        bucket_name = "gs://node-app-bucket2/"
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
                sh 'docker compose exec node npm test > docker_test.txt'
                sh 'docker compose logs > docker_logs.txt'
                sh 'docker compose down'
            }
        }
        stage("Push image to Artifact Registry") {
            steps {
                //one image as latest and other as BUILD_ID for refrenece
                sh "gcloud auth print-access-token | docker login -u oauth2accesstoken --password-stdin https://${registry_url}"
                sh "docker tag node-app-node:latest ${registry_url}${registry_path}node-app-node:latest"
                sh "docker push ${registry_url}${registry_path}node-app-node:latest"
                
                sh "docker tag node-app-node:latest ${registry_url}${registry_path}node-app-node:${BUILD_ID}"
                sh "docker push ${registry_url}${registry_path}node-app-node:${BUILD_ID}"
                
            }    
        }
        stage("Deploy to GKE cluster") {
            steps{
                sh "gcloud container clusters get-credentials node-app-cluster --region europe-west1 --project node-app-399813"
                sh "kubectl set image ${deployment_name} app-node-pod=${registry_url}${registry_path}node-app-node:${BUILD_ID} -n node-app"
                sh "sleep 10"
                sh "kubectl describe ${deployment_name} -n node-app > k8s_logs.txt"
                sh "kubectl get pods -l app=node -o custom-columns=:metadata.name --no-headers -n node-app | xargs -I {} kubectl describe pod {} -n node-app >> k8s_logs.txt"
            }
        }
        stage("Upload logs to GCS Bucket") {
            steps{
                sh "gsutil cp docker_test.txt ${bucket_name}${BUILD_ID}/"
                sh "gsutil cp docker_logs.txt ${bucket_name}${BUILD_ID}/"
                sh "gsutil cp k8s_logs.txt ${bucket_name}${BUILD_ID}/"
            }
        }
        stage("Images Cleanup") {
            steps{
                sh "docker rmi node-app-node"
                sh "docker rmi ${registry_url}${registry_path}node-app-node:latest"
                sh "docker rmi ${registry_url}${registry_path}node-app-node:${BUILD_ID}"
            }
        }
    }
    post{
        always {
            cleanWs(cleanWhenSuccess: true, deleteDirs: true, notFailBuild: true)
        }
    }
}