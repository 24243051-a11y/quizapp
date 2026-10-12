FROM eclipse-temurin:17-jdk AS build
WORKDIR /app
COPY src/main/java/com/example/quiz/QuizApplication.java src/main/java/com/example/quiz/QuizApplication.java
COPY src/main/java/com/example/quiz/QuizController.java src/main/java/com/example/quiz/QuizController.java
RUN mkdir -p /app/classes && javac -d /app/classes /app/src/main/java/com/example/quiz/QuizApplication.java /app/src/main/java/com/example/quiz/QuizController.java

FROM eclipse-temurin:17-jre
WORKDIR /app
COPY --from=build /app/classes /app/classes
EXPOSE 8080
ENTRYPOINT ["java", "-cp", "/app/classes", "com.example.quiz.QuizApplication"]
