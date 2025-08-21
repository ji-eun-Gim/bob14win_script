@echo off
setlocal EnableExtensions EnableDelayedExpansion

REM === Result folder ===
for /f %%H in ('hostname') do set HOST=%%H
for /f %%T in ('powershell -NoP -C "(Get-Date).ToString(\"yyyyMMdd_HHmmss\")"') do set DTS=%%T
set "OUT=IR_%HOST%_%DTS%"
mkdir "%OUT%" >nul 2>&1

echo.
echo [*] Output folder: %OUT%
echo.

REM ====== Collection ======
call :banner "00 Date and Time"
date /t > "%OUT%\00_date_time.txt"
time /t >> "%OUT%\00_date_time.txt"

call :banner "01 System Information"
systeminfo > "%OUT%\01_systeminfo.txt"

call :banner "02 Boot Time"
powershell -NoP -C "(Get-CimInstance Win32_OperatingSystem).LastBootUpTime" > "%OUT%\02_boot_time.txt"

call :banner "10 Network - ipconfig /all"
ipconfig /all > "%OUT%\10_ipconfig.txt"

call :banner "11 Network Sessions (net session)"
net session > "%OUT%\11_sessions.txt" 2>&1

call :banner "12 Network Ports (netstat -nao)"
netstat -nao > "%OUT%\12_netstat.txt"

call :banner "13 Logged-on Users (query user)"
query user > "%OUT%\13_loggedon_users.txt" 2>&1

call :banner "20 Services (net start)"
net start > "%OUT%\20_services.txt"

call :banner "30 Processes (tasklist /v)"
tasklist /v > "%OUT%\30_processes.txt"

call :banner "31 Process Tree (PowerShell)"
powershell -NoP -C "Get-CimInstance Win32_Process | Sort-Object ParentProcessId,ProcessId | Select-Object Name,ProcessId,ParentProcessId,CreationDate | Format-Table -AutoSize" > "%OUT%\31_process_tree.txt"

call :banner "32 DLLs per Process (PowerShell)"
powershell -NoP -C "Get-Process | ForEach-Object { '`n' + $_.Name; try { $_.Modules | Select-Object -ExpandProperty FileName } catch {} }" > "%OUT%\32_dlls.txt"

call :banner "33 Handle Counts (PowerShell)"
powershell -NoP -C "Get-Process | Select-Object Name,Id,HandleCount | Sort-Object HandleCount -Descending" > "%OUT%\33_handles.txt"

call :banner "40 Network Shares (net share)"
net share > "%OUT%\40_shares.txt"

call :banner "41 Users (net user)"
net user > "%OUT%\41_users.txt"

call :banner "42 Local Groups (net localgroup)"
net localgroup > "%OUT%\42_localgroups.txt"

call :banner "43 Administrators Group"
net localgroup administrators > "%OUT%\43_admin_group.txt"

call :banner "50 Firewall Profiles"
netsh advfirewall show allprofiles > "%OUT%\50_firewall.txt"

call :banner "60 Event Log - System (latest 50)"
wevtutil qe System /c:50 /rd:true /f:text > "%OUT%\60_eventlog_system.txt"

call :banner "61 Event Log - Security (latest 50)"
wevtutil qe Security /c:50 /rd:true /f:text > "%OUT%\61_eventlog_security.txt" 2>&1

echo.
echo [*] Completed. Results saved in folder: %OUT%
goto :eof

REM ===== Banner Function =====
:banner
echo ------------------------------------------------------------
echo [Collecting] %~1
echo ------------------------------------------------------------
goto :eof
