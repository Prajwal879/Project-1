Write-Host "===== SYSTEM MONITOR ====="

Write-Host "`nCPU Usage:"
Get-Counter '\Processor(_Total)\% Processor Time'

Write-Host "`nMemory Usage:"
Get-CimInstance Win32_OperatingSystem | Select-Object FreePhysicalMemory,TotalVisibleMemorySize

Write-Host "`nDisk Usage:"
Get-PSDrive -PSProvider FileSystem

Write-Host "`nRunning Processes:"
Get-Process | Sort-Object CPU -Descending | Select-Object -First 10