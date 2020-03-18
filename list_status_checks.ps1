$body = @{
 "state" = "success"
  "target_url" = "https://example.com/build/status"
  "description" = "The build succeeded!"
  "context" = "ensure-updated-branch"
} | ConvertTo-Json

$header = @{
 "Authorization" = "token 05205411612fcb5fa7634e5e8179a1c8394ca070"
 "Content-Type"="application/json"
}

$sha = "41fccdf4af4b9591a3c20f5f11bd4a932596db91"

Write-Host $body 
Write-Host $header

Invoke-RestMethod -Uri "https://api.github.com/repos/nakdcom/na-kd-epi-scope/commits/$sha/status" -Method 'Get' -Headers $header

git status