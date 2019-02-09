pipeline {

    agent any

    environment {
        CI = true
    }

    stages {

        stage('Build container') {
            steps {
                sh 'docker build -t backend .'
            }
        }

        /*
        stage('Plan infrastructure') {
            agent { label 'master' }
            steps {
                withCredentials([usernamePassword(credentialsId: 'aws', usernameVariable: 'USER', passwordVariable: 'PASS')]) {
                    script {
                        sh "cd terraform && terraform init -backend-config='access_key=$USER' -backend-config='secret_key=$PASS' && terraform plan -var \"env=${env.BRANCH_NAME}\" -var \"access_key=$USER\" -var \"secret_key=$PASS\" -var \"domain=${env.MY_DOMAIN}\" -out=tfplan"
                        // timeout(time: 10, unit: 'MINUTES') {
                        //    input(id: "Deploy Gate", message: "Deploy application?", ok: 'Deploy')
                        // }
                    }
                }
            }
        }

        stage('Apply infrastrcuture') {
            agent { label 'master' }
            steps {
                withCredentials([usernamePassword(credentialsId: 'aws', usernameVariable: 'USER', passwordVariable: 'PASS')]) {
                    sh "cd terraform && terraform apply -lock=false -input=false tfplan"
                }
            }
        }
        */

        stage('Deploy') {
            steps {
                sh 'echo Not implemented'
                //withAWS(region:'us-east-1', credentials:'aws') {
                //    s3Upload(file: 'build', bucket: "${env.MY_DOMAIN}-${env.BRANCH_NAME}")
                //}
            }
        }

    }
}

// vim:st=4:sts=4:sw=4:expandtab:syntax=groovy
