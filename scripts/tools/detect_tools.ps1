$tools = @('clang-format', 'clang-tidy', 'cppcheck', 'lcov', 'genhtml', 'pre-commit', 'ndk-build', 'doxygen', 'lizard', 'cloc', 'include-what-you-use', 'jscpd', 'OpenCppCoverage', 'ruby', 'gem', 'ctest', 'cmake')
$results = @()
foreach ($cmd in $tools) {
    $found = (Get-Command $cmd -ErrorAction SilentlyContinue) -ne $null
    $results += [PSCustomObject]@{Tool = $cmd; Installed = $found }
}
$results | Format-Table -AutoSize
$results | ConvertTo-Json -Depth 2 | Out-File -Encoding utf8 .\scripts\tools\detect_tools.json
Write-Host "Saved JSON to scripts/tools/detect_tools.json"