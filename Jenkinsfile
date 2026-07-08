pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-creds')
        IMAGE_NAME = "umathumma/hello-world-app"
        IMAGE_TAG = "${BUILD_NUMBER}"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/ThummaUma/hello-world-app.git',
                    credentialsId: 'github-creds'
            }
        }

        stage('Build') {
            steps {
                sh 'docker build -t $IMAGE_NAME:$IMAGE_TAG .'
            }
        }

        stage('Push to Docker Hub') {
            steps {
                sh '''
                  echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin
                  docker push $IMAGE_NAME:$IMAGE_TAG
                  docker tag $IMAGE_NAME:$IMAGE_TAG $IMAGE_NAME:latest
                  docker push $IMAGE_NAME:latest
                '''
            }
        }
    }

    post {
        success {
            echo "Pipeline completed successfully. Image: $IMAGE_NAME:$IMAGE_TAG pushed to Docker Hub."
        }
        failure {
            echo "Pipeline failed. Check logs above."
        }
    }
}
