data Messages {
    @{
        PandocNotFound   = 'Pandoc cannot be found. Ensure pandoc.exe is in your path!'
        DefaultsNotFound = 'Pandoc defaults file not found. Ensure pandoc.yaml exists in this directory!'
        Files            = 'Input Files:'
        Good             = 'Complete'
        Bad              = 'Incomplete: Pandoc returned an error'
    }
}

Set-Location $PSScriptRoot

Get-ChildItem src/*.md |
    Foreach-Object Name -OutVariable mdFiles |
    ForEach-Object { "./src/$_" } |
    Set-Variable files

if (!(Get-Command pandoc)) {
    throw $Message.PandocNotFound
}

if (!(Test-Path pandoc.yaml)) {
    throw $Message.DefaultsNotFound
}

Write-Host ($Messages.Files -f $mdFiles) -ForegroundColor Cyan
$mdFiles | Write-Host 

pandoc -d pandoc.yaml ($files)

if ($?) {
    Write-Host $Messages.Good -ForegroundColor Cyan 
}
else {
    Write-Host $Messages.Bad -ForegroundColor Magenta
}
