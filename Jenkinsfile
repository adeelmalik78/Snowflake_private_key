pipeline {
  agent {
      label 'windows'
  }
  
  environment {
        LIQUIBASE_LICENSE_KEY=credentials('LIQUIBASE_LICENSE_KEY')
	// BASE_URL="jdbc:snowflake://ba89345.us-east-2.aws.snowflakecomputing.com/?warehouse=CUSTOMERSUCCESS_WH&role=LIQUIBASE_USER"
  	LIQUIBASE_COMMAND_URL="jdbc:snowflake://ba89345.us-east-2.aws.snowflakecomputing.com/?warehouse=CUSTOMERSUCCESS_WH&db=AMDB&schema=SCHEMA1"
  }
  
  stages {

    stage('sshUserPrivateKey') {
        steps {
            cleanWs disableDeferredWipeout: true
            git branch: 'main', url: 'https://github.com/adeelmalik78/Snowflake_private_key.git'
            script {
                withCredentials([
                sshUserPrivateKey(
                    credentialsId: 'test_privatekey',     // this is the name of 
                    keyFileVariable: 'KEYFILE',
                    passphraseVariable: 'LIQUIBASE_SNOWFLAKE_AUTH_PRIVATE_KEY_PASSPHRASE',
                    usernameVariable: 'LIQUIBASE_COMMAND_USERNAME')
                ]) {
                    def LIQUIBASE_SNOWFLAKE_AUTH_PRIVATE_KEY_PATH=KEYFILE.replace("\\", "/")

                    print 'KEYFILE=' + KEYFILE
                    print 'LIQUIBASE_SNOWFLAKE_AUTH_PRIVATE_KEY_PATH=' + LIQUIBASE_SNOWFLAKE_AUTH_PRIVATE_KEY_PATH
                    print 'LIQUIBASE_SNOWFLAKE_AUTH_PRIVATE_KEY_PASSPHRASE=' + LIQUIBASE_SNOWFLAKE_AUTH_PRIVATE_KEY_PASSPHRASE
                    print 'LIQUIBASE_COMMAND_USERNAME=' + LIQUIBASE_COMMAND_USERNAME
                    print 'KEYFILE.collect { it }=' + KEYFILE.collect { it }
                    print 'LIQUIBASE_SNOWFLAKE_AUTH_PRIVATE_KEY_PASSPHRASE.collect { it }=' + LIQUIBASE_SNOWFLAKE_AUTH_PRIVATE_KEY_PASSPHRASE.collect { it }
                    print 'LIQUIBASE_COMMAND_USERNAME.collect { it }=' + LIQUIBASE_COMMAND_USERNAME.collect { it }
                    print 'KEYFILEContent=' + readFile(KEYFILE)

                    sh '''
		    	echo CURRENT WORKING DIRECTORY=$PWD
                        echo KEYFILE=%KEYFILE%
                        copy $KEYFILE adeelmalik.p8
                        dir

                        # set LIQUIBASE_COMMAND_URL="%BASE_URL%&user=adeelmalik&private_key_file=adeelmalik.p8&private_key_pwd=%PASSPHRASE%"
			# set LIQUIBASE_SNOWFLAKE_AUTH_PRIVATE_KEY_PATH="adeelmalik.p8"
			# set LIQUIBASE_COMMAND_USERNAME="%USERNAME%"
   			# set LIQUIBASE_COMMAND_URL="%BASE_URL%"
      			# C:\\Users\\Administrator\\liquibase-pro-4.32.0\\liquibase.bat --url="%BASE_URL%&user=adeelmalik&private_key_file=adeelmalik.p8&private_key_pwd=%PASSPHRASE%" connect
			
   
			# set LIQUIBASE_SNOWFLAKE_AUTH_TYPE="PKI"
		   	# set JAVA_OPTS="-Dnet.snowflake.jdbc.enableBouncyCastle=true"
                        

                        # echo LIQUIBASE_SNOWFLAKE_AUTH_TYPE=%LIQUIBASE_SNOWFLAKE_AUTH_TYPE%
			# echo LIQUIBASE_SNOWFLAKE_AUTH_PRIVATE_KEY_PATH="adeelmalik.p8"
                        # echo LIQUIBASE_COMMAND_USERNAME=%LIQUIBASE_COMMAND_USER%
			# echo LIQUIBASE_SNOWFLAKE_AUTH_PRIVATE_KEY_PASSPHRASE=%LIQUIBASE_SNOWFLAKE_AUTH_PRIVATE_KEY_PASSPHRASE%
                        
   			C:/Users/Administrator/liquibase-pro-4.32.0/liquibase connect
   
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
