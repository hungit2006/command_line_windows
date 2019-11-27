@ECHO OFF 
:: This batch file reveals OS, hardware, and networking configuration.
Title Tool Get Information PC-Laptop
CLS
ECHO TOOL GET INFORMATION PC-LAPTOP FOR YAMAHA-HCM
SET /P inputname= Please enter an computername:
:MAINMENU
ECHO.======================================================================================================================================
ECHO.
ECHO.	[1] Get OS Information			[2] Get Software Information			[3] Get Service Running
ECHO.
ECHO.	[4] Get List Windows Updates		[5] Display Printer Status			[6] Get Service Stop
ECHO. 
ECHO.	[7] Get Serial Number			[8] Get List All Local Disks			[9] Start/Stop Service				
ECHO.	
ECHO.	[10] Run Remote Desktop 		[11] Run UltraViewer				[12] Ping Test
ECHO.
ECHO.	[13] Exit
ECHO.
::choice /C:123456789 /N /M "Enter Your Choice:  "
@set /p userinp=Enter Your Choice:
@set userinp=%userinp:~0,2%
@if "%userinp%"=="1" GOTO Get_OS_Information
@if "%userinp%"=="2" GOTO Get_Software_Information
@if "%userinp%"=="3" GOTO Get_Service_Running_Information
@if "%userinp%"=="4" GOTO Get_List_Installed_Windows_Updates
@if "%userinp%"=="5" GOTO Display_Printer_Status
@if "%userinp%"=="6" GOTO Get_Service_Stop
@if "%userinp%"=="7" GOTO Get_Serial_Number
@if "%userinp%"=="8" GOTO Get_List_All_Local_Disks
@if "%userinp%"=="9" GOTO Start_Stop_Service
@if "%userinp%"=="10" GOTO Run_Remote_Desktop
@if "%userinp%"=="11" GOTO Run_UltraViewer
@if "%userinp%"=="12" GOTO Ping_Test
@if "%userinp%"=="13" GOTO Exit
::IF ERRORLEVEL 1 SET M=1
::IF ERRORLEVEL 2 SET M=2
::IF ERRORLEVEL 3 SET M=3
::IF ERRORLEVEL 4 SET M=4
::IF ERRORLEVEL 5 SET M=5
::IF ERRORLEVEL 6 SET M=6
::IF ERRORLEVEL 7 SET M=7
::IF %M%==1 GOTO Get_OS_Information
::IF %M%==2 GOTO Get_Software_Information
::IF %M%==3 GOTO Get_Service_Running_Information
::IF %M%==4 GOTO Run_Remote_Desktop
::IF %M%==5 GOTO Run_UltraViewer
::IF %M%==6 GOTO Ping_Test
::IF %M%==7 GOTO Exit
::====================================================================
:: Section 0: Enter your computer name
:Computer_Name
ECHO =================================================================
ECHO COMPUTERNAME
ECHO =================================================================
SET /P inputname= Please enter an computername:
GOTO MAINMENU
::====================================================================
:: Section 1: OS information.
:Get_OS_Information
ECHO =================================================================
ECHO OS INFOMATION
ECHO =================================================================
systeminfo /S "%inputname%" /U "%inputname%"\administrator /P "YmVn@ IT"
:: systeminfo /S do5acc90262 /U do5acc90262\administrator /P "YmVn@ IT" | findstr /c:"OS Version"
:: systeminfo /S do5acc90262 /U do5acc90262\administrator /P "YmVn@ IT" | findstr /c:"Original Install Date"
:: systeminfo /S do5acc90262 /U do5acc90262\administrator /P "YmVn@ IT" | findstr /c:"System Type"
:: systeminfo /S do5acc90262 /U do5acc90262\administrator /P "YmVn@ IT" | findstr /c:"Hotfix(s)"
ECHO.
ECHO Press key to continue...
pause >nul
CLS
GOTO MAINMENU
::====================================================================
:: Section 2: Software information.
:Get_Software_Information
ECHO =================================================================
ECHO SOFTWARE INFOMATION
ECHO =================================================================
wmic/node:"%inputname%" product get name,version
ECHO.
ECHO Press key to continue...
pause >nul
CLS
GOTO MAINMENU
::====================================================================
:: Section 3: Get Service Running
:Get_Service_Running_Information
ECHO =================================================================
ECHO SERVICE RUNNING INFORMATION
ECHO =================================================================
wmic /node:"%inputname%" service where (state="running") get caption, name, state
ECHO.
ECHO Press key to continue...
pause >nul
CLS
GOTO MAINMENU
::====================================================================
:: Section 4: Get List Installed Windows Updates
:Get_List_Installed_Windows_Updates
ECHO =================================================================
ECHO GET LIST INSTALLED WINDOWS UPDATES
ECHO =================================================================
wmic /node:"%inputname%" QFE list
ECHO.
ECHO Press key to continue...
pause >nul
CLS
GOTO MAINMENU
::====================================================================
:: Section 5: Display Printer Status
:Display_Printer_Status
ECHO =================================================================
ECHO DISPLAY PRINTER STATUS
ECHO =================================================================
wmic /node:"%inputname%" PRINTER LIST brief
ECHO.
ECHO Press key to continue...
pause >nul
CLS
GOTO MAINMENU
::====================================================================
:: Section 6: Get Service Stop
:Get_Service_Stop
ECHO =================================================================
ECHO GET SERVICE STOP
ECHO =================================================================
wmic /node:"%inputname%" service where (state="stopped") get caption, name, state
ECHO.
ECHO Press key to continue...
pause >nul
CLS
GOTO MAINMENU
::====================================================================
:: Section 7: Get Serial Number
:Get_Serial_Number
ECHO =================================================================
ECHO GET SERIAL NUMBER
ECHO =================================================================
wmic /node:"%inputname%" bios get serialnumber
ECHO.
ECHO Press key to continue...
pause >nul
CLS
GOTO MAINMENU
::====================================================================
:: Section 8: Get List All Local Disks
:Get_List_All_Local_Disks
ECHO =================================================================
ECHO GET LIST ALL LOCAL DISKS
ECHO =================================================================
wmic /node:"%inputname%" LOGICALDISK where drivetype!=4 get deviceid, description, volumename
ECHO.
ECHO Press key to continue...
pause >nul
CLS
GOTO MAINMENU
::====================================================================
:: Section 9: Start or Stop Service
:Start_Stop_Service
ECHO =================================================================
ECHO START STOP SERVICE
ECHO =================================================================
SET /P servicename= Please enter service name:
:STARTSTOPSERVICE
ECHO.========================================================================================================================================
ECHO.
ECHO.	[A] Start Service			[B] Stop Service			[C] Restart Service			[D] Main Menu
ECHO.
choice /C:ABCD /N /M "Enter Your Choice:  "
IF ERRORLEVEL 1 SET M=A
IF ERRORLEVEL 2 SET M=B
IF ERRORLEVEL 3 SET M=C
IF ERRORLEVEL 4 SET M=D
IF %M%==A GOTO Start_Service
IF %M%==B GOTO Stop_Service
IF %M%==C GOTO Restart_Service
IF %M%==D GOTO MAINMENU
::====================================================================
:: Section A: Start Service
:Start_Service
ECHO =================================================================
ECHO START SERVICE
ECHO =================================================================
SC \\%inputname% config %servicename% start= Auto
SC \\%inputname% start %servicename%
ECHO.
ECHO Press key to continue...
pause >nul
CLS
GOTO STARTSTOPSERVICE
::====================================================================
:: Section B: Stop Service
:Stop_Service
ECHO =================================================================
ECHO STOP SERVICE
ECHO =================================================================
SC \\%inputname% stop %servicename%
ECHO.
ECHO Press key to continue...
pause >nul
CLS
GOTO STARTSTOPSERVICE
::====================================================================
:: Section C: Restart Service
:Restart_Service
ECHO =================================================================
ECHO RESTART SERVICE
ECHO =================================================================
SC \\%inputname% stop %servicename%
SC \\%inputname% start %servicename%
SC \\%inputname% config %servicename% start= Auto
ECHO.
ECHO Press key to continue...
pause >nul
CLS
GOTO STARTSTOPSERVICE
::====================================================================
:: Section 10: Run Remote Desktop
:Run_Remote_Desktop
ECHO =================================================================
ECHO RUN REMOTE DESKTOP
ECHO =================================================================
mstsc
ECHO.
ECHO Press key to continue...
pause >nul
CLS
GOTO MAINMENU
::====================================================================
:: Section 11: Run UltraViewer
:Run_UltraViewer
ECHO =================================================================
ECHO RUN ULTRAVIEWER
ECHO =================================================================
runas /profile /user:.\administrator "C:\Program Files (x86)\UltraViewer\UltraViewer_Desktop.exe"
"YmVn@ IT"
ECHO.
ECHO Press key to continue...
pause >nul
CLS
GOTO MAINMENU
::====================================================================
:: Section 12: Ping Test
:Ping_Test
ECHO =================================================================
ECHO Ping Test
ECHO =================================================================
ping "%inputname%"
ECHO.
ECHO Press key to continue...
pause >nul
CLS
GOTO MAINMENU
::====================================================================
:: Section 13: Exit.
:Exit
exit /b
PAUSE