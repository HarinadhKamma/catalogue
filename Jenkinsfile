pipeline {
    agent {
        node{
            label 'agent-1'
        }
    }

    environment(){
      COURSE ="jenkins"
      appversion = ""
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
                    sh """
                       docker build -t catalogue:${appversion}
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