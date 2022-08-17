rem Bypass "Terminate Batch Job" prompt.
  if "%~1"=="-FIXED_CTRL_C" (
 REM Remove the -FIXED_CTRL_C parameter
    SHIFT
 ) ELSE (
  REM Run the batch with <NUL and -FIXED_CTRL_C
   CALL <NUL %0 -FIXED_CTRL_C %*
    GOTO :EOF
 )
set msy=0

  IF EXIST msys2_dependencies\msys2_path.txt ( 
   echo msys2 already installed
   set msy=1
   ) else (
      IF EXIST msys2-x86_64-20220603.exe (
         START /WAIT msys2-x86_64-20220603.exe
      ) else (
       powershell -Command "& {[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -UseBasicParsing 'https://github.com/msys2/msys2-installer/releases/download/2022-06-03/msys2-x86_64-20220603.exe' -OutFile msys2-x86_64-20220603.exe  }" 
       START /WAIT msys2-x86_64-20220603.exe 
       Del msys2-x86_64-20220603.exe
       )
   )
 

 IF EXIST xpack-riscv-none-embed-gcc-10.2.0-1.2 (
    echo Toolchain already extracted
    ) else (
     powershell -Command "& {[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -UseBasicParsing 'https://github.com/xpack-dev-tools/riscv-none-embed-gcc-xpack/releases/download/v10.2.0-1.2/xpack-riscv-none-embed-gcc-10.2.0-1.2-win32-x64.zip' -OutFile xpack-riscv-none-embed-gcc-10.2.0-1.2-win32-x64.zip }"  
     tar -xf xpack-riscv-none-embed-gcc-10.2.0-1.2-win32-x64.zip
    )

 IF EXIST xpack-riscv-none-embed-gcc-10.2.0-1.2-win32-x64.zip (
    echo deleting toolchain zip
    Del xpack-riscv-none-embed-gcc-10.2.0-1.2-win32-x64.zip
    )
    
   Set tempvar=0
   If EXIST RISC-V-Devkit-for-ESP32C3-SDK Set tempvar=1
   
   If EXIST esp32c3-SDK-main Set tempvar=1
   
   IF %tempvar% EQU 1 (
    echo Framework already extracted
    ) else (
        powershell -Command "& {[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -UseBasicParsing 'https://github.com/AlexManoJAM/RISC-V-Devkit-for-ESP32C3/archive/refs/heads/SDK.zip' -OutFile main.zip }" 
        tar -xf main.zip
        ren RISC-V-Devkit-for-ESP32C3-SDK esp32c3-SDK-main
    )

  IF EXIST openocd-esp32 ( 
    echo Openocd already extracted
    ) else (
      powershell -Command "& {[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -UseBasicParsing 'https://github.com/AlexManoJAM/RISC-V-Devkit-for-ESP32C3/archive/refs/heads/OpenOCD.zip' -OutFile open.zip }" 
      tar -xf open.zip
      tar -xf RISC-V-Devkit-for-ESP32C3-OpenOCD/openocd-esp32.zip
      rmdir /s /Q RISC-V-Devkit-for-ESP32C3-OpenOCD
    )
  
   IF EXIST  main.zip (
      echo deleting Framework zip
      Del main.zip
      )    

   IF EXIST open.zip (
      echo deleting Openocd zip
      Del open.zip
      )


   IF EXIST RISC-V-Devkit-for-ESP32C3-OpenOCD (
      echo deleting Openocd folder
      rmdir /s /Q RISC-V-Devkit-for-ESP32C3-OpenOCD
      )
   
   If EXIST msys2-x86_64-20220603.exe (
      echo deleting msys2-x86_64-20220603.exe
      Del msys2-x86_64-20220603.exe
      )
   IF EXIST RISC-V-Devkit-for-ESP32C3-SDK (
      echo deleting RISC-V-DEVKIT-for-ESP32C3-SDK
      echo before rmdir
      rmdir /s /Q RISC-V-DevKit-for-ESP32C3-SDK
      )


IF %msy% EQU 0 ( GOTO:SET_DIRPATH
 ) else (
   GOTO:READ_DIRPATH
 )
:READ_DIRPATH
   set /p DIRPATH=< msys2_dependencies\msys2_path.txt
   Set PATH=%DIRPATH% 
   GOTO:END

:SET_DIRPATH:
   set curdir= %cd%
   cd /
   for /F "delims=" %%I in ('dir /B /S bash.exe ^| findstr "msys64"') do set DIRPATH=%%I  
   set DIRPATH=%DIRPATH:bash.exe=%
   cd %curdir%
   echo %DIRPATH% > msys2_dependencies\msys2_path.txt
   echo %DIRPATH% > esp32c3-SDK-main\mdk-main\tools\msys2_path.txt
   Set PATH=%DIRPATH%

:END
   START /WAIT cmd /K msys2_dependencies\batch_1
 
 
