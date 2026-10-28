param(
    [string]$PythonPath = (Join-Path $env:LOCALAPPDATA 'Programs/Python/Python313/python.exe')
)

# Use the course interpreter instead of the machine-wide Python 3.14.
if (-not (Test-Path -LiteralPath $PythonPath -PathType Leaf)) {
    throw "Python 3.13 was not found: $PythonPath. Supply -PythonPath with your course interpreter."
}
& $PythonPath (Join-Path $PSScriptRoot 'boy_game.py')
exit $LASTEXITCODE
