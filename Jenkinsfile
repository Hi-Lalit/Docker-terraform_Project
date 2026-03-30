pipeline {
    agent any

    environment {
        DOCKER_HUB = "gautam009"
        IMAGE_TAG = "v1.0.${env.BUILD_NUMBER}"
    }

        stage('Terraform Apply') {
            steps {
                dir('terraform') {
                    sh 'terraform init'
                    sh 'terraform apply -auto-approve'
                }
            }
        }
       


        stage('Build Docker Images') {
            steps {
                script {
                    sh '''
                    docker build -t $DOCKER_HUB/nginx-site:$IMAGE_TAG app/webapp-nginx
                    docker build -t $DOCKER_HUB/apache-site:$IMAGE_TAG app/webapp-apache
                    '''
                }
            }
        }

        stage('Login to Docker Hub') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'docker-cred',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh '''
                    echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin
                    '''
                }
            }
        }

        stage('Push Docker Images') {
            steps {
                sh '''
                docker push $DOCKER_HUB/nginx-site:$IMAGE_TAG
                docker push $DOCKER_HUB/apache-site:$IMAGE_TAG
                '''
            }
        }

    }

    post {
        success {
            echo '✅ Deployment Successful!'
        }
        failure {
            echo '❌ Pipeline Failed!'
        }
    }
}