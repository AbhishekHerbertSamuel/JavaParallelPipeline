pipeline {
    agent {
        docker {
            image 'openjdk:11'
            args '--user root'  // Run as root to avoid permission issues
        }
    }
    environment {
        APP_ENV = "development"  // Change to "production" for production builds
        APP_VERSION = "1.0.0"
    }
    stages {
        stage("Verify Docker Access") {
            steps {
                script {
                    sh 'whoami'  // Check user running inside container
                    sh 'docker --version'  // Check if Docker is accessible
                    sh 'ls -lah /var/run/docker.sock'  // Verify Docker socket
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

