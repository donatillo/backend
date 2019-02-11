pipeline {

    agent any

    environment {
        CI = true
    }

    stages {

        stage('Build container') {
            steps {
                // sh 'docker build -t backend .'
                script {
                    docker.build('backend')
                }
            }
        }

        stage('Plan infrastructure') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'aws', usernameVariable: 'USER', passwordVariable: 'PASS')]) {
                    script {
                        sh """
                            cd terraform 
                            terraform init -backend-config='access_key=$USER' -backend-config='secret_key=$PASS' -backend-config='bucket=${env.MY_APP}-terraform' -backend-config='key=frontend-${BRANCH_NAME}.state'
                            terraform plan -no-color -out=tfplan -var \"env=${env.BRANCH_NAME}\" -var \"access_key=$USER\" -var \"secret_key=$PASS\" -var \"domain=${env.MY_DOMAIN}\" -var \"basename=${env.BASENAME}\"
                        """
                        if (env.BRANCH_NAME == "master") {
                            timeout(time: 10, unit: 'MINUTES') {
                                input(id: "Deploy Gate", message: "Deploy application?", ok: 'Deploy')
                            }
                        }
                    }
                }
            }
        }

        stage('Apply infrastrcuture') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'aws', usernameVariable: 'USER', passwordVariable: 'PASS')]) {
                    sh "cd terraform && terraform apply -no-color -lock=false -input=false tfplan"
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    withAWS(region:'us-east-1', credentials:'aws') {
                        def login = ecrLogin()
                        sh """
                            ${login}
                            docker tag backend:latest ${awsIdentity().account}.dkr.ecr.us-east-1.amazonaws.com/${env.MY_APP}-${env.BRANCH_NAME}
                            docker push ${awsIdentity().account}.dkr.ecr.us-east-1.amazonaws.com/${env.MY_APP}-${env.BRANCH_NAME}
                        """
                    }
                }
            }
        }

    }
}

// vim:st=4:sts=4:sw=4:expandtab:syntax=groovy
