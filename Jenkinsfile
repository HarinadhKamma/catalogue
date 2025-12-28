pipeline {
    agent {
        node{
            label 'agent-1'
        }
    }

    environment(){
      COURSE ="jenkins"
      appversion = ""
      account_id = "349727115914"
      project ="roboshop"
      componenet = "catalogue"
    }

    options {
        timeout(time: 30, unit: 'MINUTES') 
    }
      
    stages {
        stage('Build') {
            steps {
                script{
                    sh """
                        echo "Building"
                        echo $COURSE
                        #env
                        #sleep 10 
                    """
                }
                
            }
           
        }
        stage('Test') {
            steps {
                script{
                    sh """
                    echo "Testing.."
                    """
                }
                
            
            }
        }
        stage('Deploy') {
              input {
                message "Should we continue?"
                ok "Yes, we should."
                submitter "alice,bob"
                parameters {
                    string(name: 'PERSON', defaultValue: 'Mr Jenkins', description: 'Who should I say hello to?')
                }
            }
            steps {
                script{
                    sh """
                    echo "Deploying...."
                  
                    """
                }
                
            }
        }

        stage('Read Version') {
            steps {
                script{
                    def packagejson =  readJSON file: 'package.json'
                    appversion = packagejson.version
                    echo "App version is ${appversion}"

                }
                
            
            }
        }

         stage('build image') {
            steps {
                script{
                    withAWS(credentials:'aws-cred') {
    // do something
}
                    sh """
                      aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin ${account_id}.dkr.ecr.us-east-1.amazonaws.com
                      docker build -t  roboshop/catalogue:latest 349727115914.dkr.ecr.us-east-1.amazonaws.com/${project}/${component}:${appversion}
                       docker images
                       docker push ${appversion}.dkr.ecr.us-east-1.amazonaws.com/${component}/${component}:latest
                       """
                }
                
            
            }
        }

         stage('Install Dependencies') {
            steps {
                script{
                    sh """
                     npm install
                    """
                }
                
            
            }
        }
    }
        post{
            always{
                cleanWs()
            }
            success{
                echo "this is success case "
            }
            failure{
                echo "this is faile case"
            }
            aborted{
                echo "this case is aborted"
            }
        }
}