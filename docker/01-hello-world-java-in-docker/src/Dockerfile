FROM ubuntu:20.04
WORKDIR /app
RUN  apt update && apt install openjdk-11-jdk -y
COPY ./HelloWorld.java ./jarHelloWorld.txt ./
RUN javac HelloWorld.java && jar cvfm HelloWorld.jar jarHelloWorld.txt HelloWorld.class
CMD ["java", "-jar" , "/app/HelloWorld.jar" ] 
