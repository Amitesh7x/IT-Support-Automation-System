$ReportPath = "../Reports/System_Report.html"

$Computer = $env:COMPUTERNAME
$Date = Get-Date

$OS = Get-CimInstance Win32_OperatingSystem

$CPU = Get-CimInstance Win32_Processor

$RAM = [math]::Round($OS.FreePhysicalMemory/1MB,2)

$Disk = Get-PSDrive C

$IP = Get-NetIPAddress -AddressFamily IPv4 |
Where-Object {$_.InterfaceAlias -notlike "*Loopback*"}

$Internet = Test-Connection google.com -Count 2 -Quiet

$Errors = Get-EventLog System -EntryType Error -Newest 5


$html = @"

<h1>IT Support System Health Report</h1>

<h3>Basic Details</h3>

Computer Name: $Computer <br>

Date: $Date <br>

Windows Version: $($OS.Caption) <br>


<h3>CPU Information</h3>

Processor:
$($CPU.Name)

<h3>Memory Status</h3>

Free RAM:
$RAM GB


<h3>Disk Status</h3>

Available C Drive:
$($Disk.Free/1GB) GB


<h3>Network Status</h3>

Internet Working:
$Internet


<h3>Recent System Errors</h3>

$Errors

"@

$html | Out-File $ReportPath

Write-Host "System Health Report Created Successfully"