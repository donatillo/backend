FROM gradle:jdk8-alpine as builder
ENV GRADLE_OPTS "-Xmx256m"
COPY backend .
RUN gradle --no-daemon test bootJar

FROM openjdk:8-jre-alpine
RUN mkdir /app
WORKDIR /app
COPY --from=builder /home/gradle/build/libs/backend-*.jar .
RUN mv backend-*.jar backend.jar
CMD ["java", "-jar", "backend.jar"]

EXPOSE 8080

# TODO - expose port
# TODO - install nginx
# TODO - add https
