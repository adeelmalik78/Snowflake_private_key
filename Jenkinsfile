pipeline {
  agent {
      label 'windows'
  }
  
  environment {
		BASE_URL="jdbc:snowflake://netjets.us-east-2.aws.snowflakecomputing.com/?warehouse=CUSTOMERSUCCESS_WH&role=LIQUIBASE_USER"
// 		LIQUIBASE_COMMAND_URL="jdbc:snowflake://netjets.us-east-2.aws.snowflakecomputing.com/?warehouse=ETL_PROD_WH&role=SVC_LIQUIBASE_DEPLOY_ROLE&user=${USERNAME}&private_key_file=${KEYFILE}&private_key_pwd=${PASSPHRASE}"
  }
  
  stages {

    stage('sshUserPrivateKey') {
        steps {
            script {
              withCredentials([
                sshUserPrivateKey(
                      credentialsId: 'test_privatekey',     // this is the name of 
                      keyFileVariable: 'KEYFILE',
                      passphraseVariable: 'PASSPHRASE',
                      usernameVariable: 'USERNAME')
                ]) {
                    bat '''
                        set LIQUIBASE_COMMAND_URL="${BASE_URL}&user=${USERNAME}&private_key_file=${KEYFILE}&private_key_pwd=${PASSPHRASE}"
                        echo LIQUIBASE_COMMAND_URL=${LIQUIBASE_COMMAND_URL}

                    '''
                    echo 'keyFile=${KEYFILE}'

                    print 'keyFile=' + KEYFILE
                    print 'passphrase=' + PASSPHRASE
                    print 'username=' + USERNAME
                    print 'keyFile.collect { it }=' + keyFile.collect { it }
                    print 'passphrase.collect { it }=' + passphrase.collect { it }
                    print 'username.collect { it }=' + username.collect { it }
                    print 'keyFileContent=' + readFile(keyFile)

                    bat '''
                    C:\Users\Administrator\liquibase-4.29.0\liquibase.bat connect
                    '''
                }
            }
      }
    }

    // stage('secretsFile') {
    //   steps {
    //     script {
    //         withCredentials([file(credentialsId: 'adeelmalik.p8', variable: 'FILE')]) {
    //                           withCredentials([
    //             sshUserPrivateKey(
    //                   credentialsId: 'test_privatekey',     // this is the name of 
    //                   keyFileVariable: 'KEYFILE',
    //                   passphraseVariable: 'PASSPHRASE',
    //                   usernameVariable: 'USERNAME')
    //             ]) {
    //             sh '''
    //                 dir
    //                 more $FILE
    //                 export LIQUIBASE_COMMAND_URL="${BASE_URL}&user=${USERNAME}&privateKey_file=${FILE}"
    //                 echo LIQUIBASE_COMMAND_URL=${LIQUIBASE_COMMAND_URL}
    //                 export LIQUIBASE_COMMAND_URL="${BASE_URL}&user=${USERNAME}&private_key_file=${KEYFILE}&private_key_pwd=${PASSPHRASE}"
    //                 echo LIQUIBASE_COMMAND_URL=${LIQUIBASE_COMMAND_URL}
    //             '''
    //             }
    //         }
    //     }
    //   }
    // }
  }
}   