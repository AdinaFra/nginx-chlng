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
	}
}
