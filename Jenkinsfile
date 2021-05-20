pipeline {
    agent any
    tools{
        maven 'Maven'
    }
    
    environment {
        DOCKER_TAG = "getVersion()"
    }
    
    stages{
        stage("SCM"){
            steps{
                git branch: 'main', credentialsId: 'GitHub', url: 'https://github.com/RajanikanthGitHub/dockeransiblejenkins.git'
            }
        }
        stage("Maven Build"){
            steps{
                sh 'mvn clean package'
            }
        }
        stage("Docker Build"){
            steps{
                sh "docker build . -t rnagelli/mavenweb:${DOCKER_TAG} "
            }
        }
        stage("Docker Push"){
            steps{
                withCredentials([string(credentialsId: 'docker-hub-pwd', variable: 'DockerHubpwd')]) {
                    sh "docker login -u rnagelli -p ${DockerHubpwd}"
                }
                sh "docker push rnagelli/mavenweb:${DOCKER_TAG} "
            }
        }
        stage("Docker Deploy"){
            steps{
                ansiblePlaybook credentialsId: 'Dev-Server-pem', disableHostKeyChecking: true, extras: "-e DOCKER_TAG=${DOCKER_TAG}", installation: 'ansible', inventory: 'dev.inv', playbook: 'docker-deploy.yml'
            }
        }

    }
}

def getVersion(){
    def commithash = sh returnStdout: true, script: 'git rev-parse --short HEAD'
    return commithash
}