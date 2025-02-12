FROM jenkins/jenkins:lts

USER root

# Install OpenJDK 18
RUN apt-get update && apt-get install -y openjdk-18-jdk && \
    apt-get clean

# Set Java Environment Variables
ENV JAVA_HOME=/usr/lib/jvm/java-18-openjdk-amd64
ENV PATH=$JAVA_HOME/bin:$PATH

# Allow Docker inside Jenkins container
RUN apt-get install -y docker.io && \
    usermod -aG docker jenkins

# Expose Jenkins Port
EXPOSE 9090

# Start Jenkins
CMD ["java", "-jar", "/usr/share/jenkins/jenkins.war"]
