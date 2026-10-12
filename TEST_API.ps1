# Run this script in PowerShell after starting the container.
Write-Host "1. Health check"
Invoke-RestMethod -Uri "http://localhost:8080/api/health"
Write-Host "`n2. List quiz questions"
Invoke-RestMethod -Uri "http://localhost:8080/api/quiz" | ConvertTo-Json -Depth 5
Write-Host "`n3. Submit correct answer for question 1 (optionIndex 0)"
Invoke-RestMethod -Method Post -Uri "http://localhost:8080/api/quiz/1/answer" -ContentType "application/json" -Body '{"optionIndex":0}' | ConvertTo-Json
