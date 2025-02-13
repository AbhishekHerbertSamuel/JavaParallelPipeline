pipeline {
    agent any
    environment {
        JAVA_HOME = "/usr/local/openjdk-18"
        PATH = "${JAVA_HOME}/bin:${env.PATH}"
        APP_ENV = "development"
        APP_VERSION = "1.0.0"
    }
    stages {
        stage("Start Docker Compose") {
            steps {
                sh "docker-compose up -d"
                sh "docker-compose ps" // Check running containers
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
        stage("Verify Java Setup") {
            steps {
                sh "java -version"
                sh "javac -version"
            }
        }
        stage("Parallel Compilation") {
            parallel {
                stage("Task 1 Compilation") {
                    steps {
                        echo "Compiling Task 1..."
                        sh "mkdir -p build"
                        sh "javac -d build/ src/Task1.java"
                    }
                }
                stage("Task 2 Compilation") {
                    steps {
                        echo "Compiling Task 2..."
                        sh "mkdir -p build"
                        sh "javac -d build/ src/Task2.java"
                    }
                }
            }
        }
        stage("Archive Artifacts") {
            steps {
                archiveArtifacts artifacts: "build/*.class", fingerprint: true
                echo "✅ Compiled files archived."
            }
        }
        stage("Stop Docker Compose") {
            steps {
                sh "docker-compose logs" // Capture logs before stopping
                sh "docker-compose down"
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


