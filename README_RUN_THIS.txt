SPRING BOOT QUIZ API + DOCKER — RUN GUIDE (Windows)
==================================================

WHAT IS INCLUDED?
- Spring Boot Java REST API source code
- Dockerfile to build the image
- .dockerignore
- Maven pom.xml
- This run guide and API test examples

REQUIREMENTS
1. Install Docker Desktop for Windows and start it. Wait until Docker Desktop says it is running.
2. Install Git only if you want to push the project to GitHub.
3. Internet is needed on the first Docker build to download Maven/Java dependencies.

STEP 1 — EXTRACT THE ZIP
Extract quiz-springboot-docker.zip. Open the extracted quiz-springboot-docker folder in VS Code.
Open Terminal > New Terminal. Make sure the terminal is inside the folder containing Dockerfile and pom.xml.

STEP 2 — BUILD THE DOCKER IMAGE LOCALLY
Run:
    docker build -t quiz-app:1.0 .

Wait until the build finishes successfully. The dot at the end is important.
To confirm the image exists:
    docker images

If you get a Docker error such as "docker: not found", "Cannot connect to the Docker daemon", or "driver not running", then Docker Desktop is not running yet. Start Docker Desktop, wait for it to show "Docker Desktop is running", and then retry the command.

STEP 3 — RUN THE CONTAINER
Run:
    docker run -d --name quiz-api -p 8080:8080 quiz-app:1.0

Check that it is running:
    docker ps

If the container name already exists, or port 8080 is already in use, remove the old container and retry on another host port:
    docker rm -f quiz-api
    docker run -d --name quiz-api -p 8081:8080 quiz-app:1.0
Then use port 8081 in the URLs below.

If Docker still refuses to start, verify the engine is running:
    docker info

STEP 4 — VERIFY THE API
Open these URLs in a browser:
    http://localhost:8080/api/health
    http://localhost:8080/api/quiz
    http://localhost:8080/api/quiz/1

Expected health response:
    {"status":"UP","application":"quiz-app"}

The quiz endpoint should return 3 questions and their multiple-choice options. Correct answers are not exposed by the GET endpoints.

STEP 5 — TEST ANSWER SUBMISSION
In VS Code terminal / PowerShell, run this command:
    Invoke-RestMethod -Method Post -Uri "http://localhost:8080/api/quiz/1/answer" -ContentType "application/json" -Body '{"optionIndex":0}'

Question 1 optionIndex 0 is the correct answer. The response should contain correct=True and a message saying Correct answer!

To test a wrong answer:
    Invoke-RestMethod -Method Post -Uri "http://localhost:8080/api/quiz/1/answer" -ContentType "application/json" -Body '{"optionIndex":1}'

STEP 6 — VIEW LOGS AND STOP
View logs:
    docker logs quiz-api
Stop the container:
    docker stop quiz-api
Start it again:
    docker start quiz-api
Remove it when finished:
    docker rm -f quiz-api

USEFUL DOCKER COMMANDS
    docker ps                 Shows running containers
    docker ps -a              Shows all containers
    docker images              Shows local images
    docker logs quiz-api       Shows application logs

OPTIONAL — PUSH THIS PROJECT TO YOUR GITHUB
Create an empty repository on GitHub (do not add README or .gitignore there).
From this project folder, run:
    git init
    git add .
    git commit -m "Add Spring Boot quiz API with Docker"
    git branch -M main
    git remote add origin https://github.com/YOUR-USERNAME/YOUR-REPOSITORY.git
    git push -u origin main
Replace the URL with your own GitHub repository URL.

IMPORTANT
- This is a ready-to-build project source package; the Docker image is built on your computer.
- Docker Desktop must be running before docker build or docker run.
- The quiz data is in memory and resets when the app/container restarts. No database is required for this lab task.
