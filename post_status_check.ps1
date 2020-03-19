$token = $env:NAKD_GITHUB_TOKEN
Write-Host token: $token

if (-Not ($token)){
  Write-Host "Please set a valid OAUTH token to environment variable 'NAKD_GITHUB_TOKEN'"
  return
}

$body = @{
 "state" = "success"
  "target_url" = "https://example.com/build/status"
  "description" = "The build succeeded!"
  "context" = "ensure-updated-branch"
} | ConvertTo-Json

$header = @{
 "Authorization" = "token 6dcfc8c70084a1a71016c777e268e9ffd7a012d9"
 "Content-Type"="application/json"
}

$sha = (git rev-parse master) | Out-String

Write-Host $sha
Write-Output $header.Values
Write-Host $body

git push

Invoke-RestMethod -Uri "https://api.github.com/repos/peterrothman/shooter/statuses/$sha" -Method 'Post' -Body $body -Headers $header