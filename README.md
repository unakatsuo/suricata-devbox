
## Note for build.ps1

To clone the private repository, valid [personal accesss token](https://github.com/settings/tokens) is required prior to running ``build.ps1``.

```
$env:BRANCH="feature-foo"
$env:GITHUB_USER="github"
$env:GITHUB_TOKEN="0123456789abcdef"
powershell -ExecutionPolicy Bypass .\build.ps1
```
