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

        stage('Debug kubectl') {
            steps {
                sh '''
                    echo "========== DEBUG =========="

                    echo "Hostname:"
                    hostname

                    echo "Current User:"
                    whoami

                    echo "Working Directory:"
                    pwd

                    echo "PATH:"
                    echo $PATH

                    echo "Which kubectl:"
                    which kubectl || true

                    echo "List /usr/local/bin:"
                    ls -la /usr/local/bin

                    echo "Check kubectl file:"
                    ls -l /usr/local/bin/kubectl || true

                    echo "Shared Library Dependencies:"
                    ldd /usr/local/bin/kubectl || true

                    echo "kubectl Version:"
                    /usr/local/bin/kubectl version --client || true

                    echo "========== END DEBUG =========="
                '''
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                withCredentials([file(credentialsId: 'kubeconfig-cred', variable: 'KUBECONFIG')]) {
                    sh '''
                        /usr/local/bin/kubectl set image deployment/hello-world-app hello-world-app=$IMAGE_NAME:$IMAGE_TAG --record
                        /usr/local/bin/kubectl rollout status deployment/hello-world-app
                    '''
                }
            }
        }
    }

    post {
        success {
            echo "Pipeline completed successfully. Image ${IMAGE_TAG} deployed to Kubernetes."
        }

        failure {
            echo "Pipeline failed. Check logs above."
        }
    }
}

