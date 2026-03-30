pipeline {
    agent any

    parameters {
        choice(
            name: 'TERRAFORM_ACTION', 
            choices: ['apply', 'destroy'], 
            description: 'Choose Terraform action'
        )
    }

    environment {
        DOCKER_HUB = "gautam009"
        IMAGE_TAG = "v1.0.${env.BUILD_NUMBER}"
    }

    stages {

        stage('Terraform Action') {
            steps {
                dir('terraform') {
                    withCredentials([[
                        $class: 'AmazonWebServicesCredentialsBinding',
                        credentialsId: 'aws-cred'
                    ]]) {
                        script {
                            if (params.TERRAFORM_ACTION == 'apply') {
                                sh '''
                                terraform init
                                terraform apply -auto-approve
                                '''
                            } else if (params.TERRAFORM_ACTION == 'destroy') {
                                input message: 'Are you sure you want to destroy infrastructure?'
                                sh '''
                                terraform init
                                terraform destroy -auto-approve
                                '''
                            }
                        }
                    }
                }
            }
        }

        stage('Build Docker Images') {
            steps {
                sh '''
                docker build -t $DOCKER_HUB/nginx-site:$IMAGE_TAG app/webapp-nginx
                docker build -t $DOCKER_HUB/apache-site:$IMAGE_TAG app/webapp-apache
                '''
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