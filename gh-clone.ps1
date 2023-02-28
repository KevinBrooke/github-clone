#Requires -Version 3.0

Param {
    [string]$org
}

gh auth login -w

$repos = gh repo list $org --limit 9999 --source --json nameWithOwner | ConvertFrom-Json

foreach ($repo in $repos) {
    if(-not (Test-Path -Path $repo.nameWithOwner -PathType Container)) {
        Write-Warning -Message "Cloning repo $($repo.nameWithOwner)"
        gh repo clone $repo.nameWithOwner $repo.nameWithOwner
    }
}