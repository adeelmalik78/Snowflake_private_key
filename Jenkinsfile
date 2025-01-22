pipeline {
  agent {
      label 'windows'
  }
  
  environment {
        LIQUIBASE_LICENSE_KEY=credentials('LIQUIBASE_LICENSE_KEY')
		BASE_URL="jdbc:snowflake://ba89345.us-east-2.aws.snowflakecomputing.com/?warehouse=CUSTOMERSUCCESS_WH&role=LIQUIBASE_USER"
  }
  
  stages {

    stage('sshUserPrivateKey') {
        steps {
            withCredentials([
            sshUserPrivateKey(
                credentialsId: 'test_privatekey',     // this is the name of 
                keyFileVariable: 'KEYFILE',
                passphraseVariable: 'PASSPHRASE',
                usernameVariable: 'USERNAME')
            ]) {
                newKeyFilePath = keyFile.replace("\\\\", "/")
                print 'keyFile=' + KEYFILE
                print 'passphrase=' + PASSPHRASE
                print 'username=' + USERNAME
                print 'keyFile.collect { it }=' + keyFile.collect { it }
                print 'newKeyFile.collect { it }=' + newKeyFile.collect { it }
                print 'passphrase.collect { it }=' + passphrase.collect { it }
                print 'username.collect { it }=' + username.collect { it }
                print 'keyFileContent=' + readFile(keyFile)

                bat '''
                    echo KEYFILE=%KEYFILE%
                    set LIQUIBASE_COMMAND_URL="%BASE_URL%&user=adeelmalik&private_key_file=%KEYFILE%&private_key_pwd=%PASSPHRASE%"
                    set JAVA_OPTS="-Dnet.snowflake.jdbc.enableBouncyCastle=true"
                    echo LIQUIBASE_COMMAND_URL=%LIQUIBASE_COMMAND_URL%
                    C:\\Users\\Administrator\\liquibase-4.29.0\\liquibase.bat connect
                '''
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