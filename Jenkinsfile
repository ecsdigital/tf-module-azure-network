pipeline {
    agent any
    environment {
      TF_VAR_subscription_id = credentials('cred_subscription_id')
      TF_VAR_client_id = credentials('cred_client_id')
      TF_VAR_client_secret = credentials('cred_client_secret')
      TF_VAR_tenant_id = credentials('cred_tenant_id')
    }
    stages {
        stage('Terraform Init') {
            steps {
                sh "echo $TF_VAR_subscription_id"
                sh 'terraform init -input=false'
            }
        }
        stage('Validations'){
            parallel {
                stage('Validate Terraform configurations') {
                    steps {
                        sh 'find . -type f -name "*.tf" -exec dirname {} \\;|sort -u | while read m; do (terraform validate -check-variables=false "$m" && echo "√ $m") || exit 1 ; done'
                    }
                }
                stage('Check if Terraform configurations are properly formatted') {
                    steps {
                        sh "if [[ -n \"\$(terraform fmt -write=false)\" ]]; then echo \"Some terraform files need be formatted, run 'terraform fmt' to fix\"; exit 1; fi"
                    }
                }
                stage('Check Terraform configurations with tflint'){
                    steps {
                        // To install tflint
                        // sh "curl -L -o /tmp/tflint.zip https://github.com/wata727/tflint/releases/download/v0.4.2/tflint_linux_amd64.zip && unzip /tmp/tflint.zip -d /usr/local/bin"
                        sh "tflint"
                    }
                }
            }
        }
        stage('Terraform Kitchen') {
            steps {
                sh 'bundle install'
                sh 'bundle exec kitchen converge'
                sh 'bundle exec kitchen verify'
                sh 'bundle exec kitchen destroy'
            }
        }
        stage('Approve new module') {
            steps {
                input 'Should we create a new version for this module?'
            }
        }
        stage('Release new module') {
            steps {
                // Create new relase in Github
                echo 'New module updated in Terraform Enterprise'
                sh "printenv"
            }
        }
    }
}
