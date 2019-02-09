FROM gradle:jdk8-alpine
COPY backend .
RUN gradle bootJar

FROM gradle:jre8-alpine
COPY --from=0 build/libs/backend-*.jar ./backend.jar
CMD ["java", "-jar", "backend.jar"]
