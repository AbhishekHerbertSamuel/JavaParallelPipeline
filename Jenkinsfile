pipeline {
    agent any  // Use system-installed Java instead of Docker
    environment {
        JAVA_HOME = "/Library/Java/JavaVirtualMachines/jdk-18.0.2.jdk/Contents/Home"
        PATH = "${JAVA_HOME}/bin:${env.PATH}"
        APP_ENV = "development"  // Change to "production" for production builds
        APP_VERSION = "1.0.0"
    }
    stages {
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
                        sh "javac -d build/ src/Task1.java"
                    }
                }
                stage("Task 2 Compilation") {
                    steps {
                        echo "Compiling Task 2..."
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
    }
    post {
        always {
            echo "📌 Cleaning up workspace..."
            cleanWs()
        }
    }
}

