# Start all Legal Multi-Agent System services safely on Windows
# Registry must be first, then leaf agents, then orchestrators

$pythonPath = ".\.venv\Scripts\python.exe"
$processes = @()

if (-not (Test-Path $pythonPath)) {
    Write-Error "Could not find python.exe in .venv. Please make sure you have run 'uv sync' or created the virtual environment."
    exit 1
}

try {
    Write-Host "Starting Registry service on port 10000..."
    $p1 = Start-Process -PassThru -NoNewWindow -FilePath $pythonPath -ArgumentList "-m", "registry"
    $processes += $p1
    Start-Sleep -Seconds 2

    Write-Host "Starting Tax Agent on port 10102..."
    $p2 = Start-Process -PassThru -NoNewWindow -FilePath $pythonPath -ArgumentList "-m", "tax_agent"
    $processes += $p2

    Write-Host "Starting Compliance Agent on port 10103..."
    $p3 = Start-Process -PassThru -NoNewWindow -FilePath $pythonPath -ArgumentList "-m", "compliance_agent"
    $processes += $p3
    Start-Sleep -Seconds 3

    Write-Host "Starting Law Agent on port 10101..."
    $p4 = Start-Process -PassThru -NoNewWindow -FilePath $pythonPath -ArgumentList "-m", "law_agent"
    $processes += $p4
    Start-Sleep -Seconds 3

    Write-Host "Starting Customer Agent on port 10100..."
    $p5 = Start-Process -PassThru -NoNewWindow -FilePath $pythonPath -ArgumentList "-m", "customer_agent"
    $processes += $p5

    Write-Host ""
    Write-Host "All services started safely in background:"
    Write-Host "  Registry:         http://localhost:10000"
    Write-Host "  Customer Agent:   http://localhost:10100"
    Write-Host "  Law Agent:        http://localhost:10101"
    Write-Host "  Tax Agent:        http://localhost:10102"
    Write-Host "  Compliance Agent: http://localhost:10103"
    Write-Host ""
    Write-Host "Run test_client.py in another terminal to send a query:"
    Write-Host "  uv run python test_client.py"
    Write-Host ""
    Write-Host "Press Ctrl+C here to safely stop all services."

    # Keep script alive to wait for user to press Ctrl+C
    while ($true) {
        Start-Sleep -Seconds 1
    }
}
finally {
    Write-Host ""
    Write-Host "Stopping all agent services safely..."
    foreach ($p in $processes) {
        if ($null -ne $p -and -not $p.HasExited) {
            Stop-Process -Id $p.Id -Force -ErrorAction SilentlyContinue
        }
    }
    Write-Host "Done!"
}
