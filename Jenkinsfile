pipeline {
    agent any
    options {
        timestamps()
    }
    environment {
        IMAGE = "adinafra/nginx-chlng"
        buildName = "nginx-chlng"
    }
    stages {
            stage('build') {
                steps {
                    script {
                            currentBuild.displayName = "Starting nginx"
                            currentBuild.description = "Building docker container"
                        try {
                            image = docker.build("${IMAGE}")
                            println "nginx Docker image, " + image.id
                        }catch (Exception e){
                                    println "There was an exception during the buidling: ${e.message}"
                        }
                    }

                }

            }
            stage('run') {
                steps {
                    script {
                        sh """
                        docker stop nginx || true && docker rm nginx || true
                        """
                        def container = image.run('--name nginx -p 80:8080')
                        def date = new Date().format("dd.MM.yyy")

                        def resp = sh returnStdout: true,script:'curl -w "%{http_code}" -o /dev/null -s http://localhost/'

                        if ( resp == "200" ) {
                            println "nginx works"
                            currentBuild.result = "SUCCESS"
                            sh """
                            mkdir output || true
                            curl -o ${env.BUILD_ID}_${date}_nginx.out -s http://localhost/
                            """
                        }
                        else {
                            println "Build failed. Please check ${env.BUILD_URL}"
                            currentBuild.result = "FAILURE"
                        }
                    }
                }
            }
            stage('Archive') {
            steps {

                                archiveArtifacts artifacts: '**/*_nginx.out', onlyIfSuccessful: false
           		 }
        	}
	 }
}
