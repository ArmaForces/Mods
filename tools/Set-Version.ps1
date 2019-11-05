param (
    [string] $version,
    [string] $addonDir
)

$modCppPath = $PSScriptRoot + "/../releases/$version/$addonDir/mod.cpp"

$replaced = (Get-Content $modCppPath) -replace "0.0.0", "$version"

$replaced | Out-File $modCppPath
