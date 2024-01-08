# Use the official OpenJDK 11 base image
FROM openjdk:8

# Set the working directory in the container
WORKDIR /app

# Copy the packaged JAR file into the container at the defined working directory
COPY target/*.jar wms_app.jar

# Expose the port the app runs on
EXPOSE 8080

# Specify the command to run on container start
CMD ["java", "-jar", "wms_app.jar"]
