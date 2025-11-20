# Use official Eclipse Temurin OpenJDK 17 image
FROM eclipse-temurin:17-jdk

# Set working directory inside the container
WORKDIR /app

# Copy Maven wrapper and pom.xml
COPY mvnw pom.xml ./
COPY .mvn .mvn

# Give execute permission
RUN chmod +x mvnw

# Copy source code
COPY src src

# Build the JAR inside Docker (skip tests)
RUN ./mvnw clean package -DskipTests

# The JAR is now inside target/, copy it to app.jar
RUN cp target/sb-ecom-0.0.1-SNAPSHOT.jar app.jar

# Expose port
EXPOSE 8080

# Environment variables from Render
ENV DB_URL=${DB_URL}
ENV DB_USERNAME=${DB_USERNAME}
ENV DB_PASSWORD=${DB_PASSWORD}
ENV JWT_SECRET=${JWT_SECRET}

# Run the app
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
