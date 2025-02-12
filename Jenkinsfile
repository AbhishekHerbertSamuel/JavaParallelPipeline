pipeline {
    agent {
        docker {
            image 'openjdk:11'
            args '--user root -v /Users/abhishekherbertsamuel/.docker/run/docker.sock:/var/run/docker.sock'
        }
    }
    environment {
        APP_ENV = "development"
        APP_VERSION = "1.0.0"
    }
    stages {
        stage("Verify Docker Access") {
            steps {
                script {
                    sh 'whoami'  // Check user inside container
                    sh 'docker --version'  // Verify Docker access
                    sh 'ls -lah /var/run/docker.sock'  // Ensure the socket is mounted
                }
            }
        }
        stage("Initialize") {
            steps {
                script {
                    if (env.APP_ENV == "production") {
                        echo "🚀 Production Build: Deploying Java Application"
                    } else {
                        echo "🛠 Development Build: Running Java Compilation"
                    }
                }
            }
        }
        stage("Parallel Compilation") {
            parallel {
                stage("Task 1 Compilation") {
                    steps {
                        echo "Compiling Task 1..."
                        sh "javac -d build/ src/Task1.java"
                        sh "echo 'Hello Jenkins from Task 1.' > build/Task1.txt"
                    }
                }
                stage("Task 2 Compilation") {
                    steps {
                        echo "Compiling Task 2..."
                        sh "javac -d build/ src/Task2.java"
                        sh "echo 'Hello Jenkins from Task 2.' > build/Task2.txt"
                    }
                }
            }
        }
        stage("Archive Artifacts") {
            steps {
                archiveArtifacts artifacts: "build/*.class, build/*.txt", fingerprint: true
                echo "✅ Compiled files archived."
            }
        }
    }
    post {
        always {
            echo "📌 Cleaning up workspace..."
            cleanWs()
        }
    }
}
