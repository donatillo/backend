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
                            terraform init -backend-config='access_key=$USER' -backend-config='secret_key=$PASS' -backend-config='bucket=give-and-take-terraform-${BRANCH_NAME}'
                            terraform plan -no-color -out=tfplan -var \"env=${env.BRANCH_NAME}\" -var \"access_key=$USER\" -var \"secret_key=$PASS\" -var \"domain=${env.MY_DOMAIN}\"
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
                // TODO - how will I know the registry name?
                script {
                    withAWS(region:'us-east-1', credentials:'aws') {
                        def login = ecrLogin()
                        sh """
                            ${login}
                            docker tag backend:latest ${awsIdentity().account}.dkr.ecr.us-east-1.amazonaws.com/${env.BRANCH_NAME}.giveandtake
                            docker push ${awsIdentity().account}.dkr.ecr.us-east-1.amazonaws.com/${env.BRANCH_NAME}.giveandtake
                        """
                    }
                }
            }
        }

    }
}

// vim:st=4:sts=4:sw=4:expandtab:syntax=groovy
