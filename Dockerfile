FROM eclipse-temurin:21-jdk-alpine AS build

WORKDIR /app

# Копируем Maven проект
COPY pom.xml .
COPY src ./src

# Собираем приложение
RUN apk add --no-cache maven && \
    mvn clean package -DskipTests

# Финальный образ
FROM eclipse-temurin:21-jre-alpine

WORKDIR /app

# Копируем JAR
COPY --from=build /app/target/*.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]