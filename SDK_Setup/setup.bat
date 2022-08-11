rem Bypass "Terminate Batch Job" prompt.
 if "%~1"=="-FIXED_CTRL_C" (
rem  REM Remove the -FIXED_CTRL_C parameter
   SHIFT
 ) ELSE (
  REM Run the batch with <NUL and -FIXED_CTRL_C
   CALL <NUL %0 -FIXED_CTRL_C %*
   GOTO :EOF
)


 IF EXIST msys2_dependencies\msys2_path.txt ( echo msys2 already installed
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
::IF EXIST mdk-main (
::    echo Framework already extracted
::    ) else (
::    powershell -Command "& {[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -UseBasicParsing 'https://github.com/cpq/mdk/archive/refs/heads/main.zip' -OutFile main.zip }" 
::    tar -xf main.zip
::    )

::IF EXIST openocd-esp32c3-modifications-main (
 ::   echo Openocd executable already extracted
 ::   ) else (
::    powershell -Command "& {[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -UseBasicParsing 'https://github.com/AlexManoJAM/openocd-esp32c3-modifications/archive/refs/heads/main.zip' -OutFile openocd-esp32c3-modifications-main.zip }" 
 ::    tar -xf openocd-esp32c3-modifications-main.zip
 ::    tar -xf openocd-esp32c3-modifications-main\openocd-esp32.zip    
  ::  )

 IF EXIST xpack-riscv-none-embed-gcc-10.2.0-1.2-win32-x64.zip (
    echo deleting toolchain zip
    Del xpack-riscv-none-embed-gcc-10.2.0-1.2-win32-x64.zip
    )

Set "_tempvar="
If EXIST RISC-V-Devkit-for-ESP32C3-SDK Set "_tempvar=1"
If EXIST esp32c3-SDK-main Set "_tempvar=1"
if %_tempvar% EQU 1 (
    echo Framework already extracted
    ren RISC-V-Devkit-for-ESP32C3-SDK esp32c3-SDK-main
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
        Del RISC-V-Devkit-for-ESP32C3-OpenOCD
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
   
   if EXIST RISC-V-Devkit-for-ESP32C3-SDK(
      echo deleting RISC-V-DEVKIT-for-ESP32C3-SDK
      rmdir /s /Q RISC-V-DevKit-for-ESP32C3-SDK
      )
   

cd /
for /F "delims=" %%I in ('dir /B /S bash.exe | findstr "msys64"') do set DIRPATH=%%I
rem set DIRPATH=%DIRPATH:bash.exe=%
echo %DIRPATH% > esp32c3-SDK-main\mdk-main\tools\msys2_path.txt
Set PATH=%DIRPATH%
echo 1 >instalation_verification.txt
pause
START /WAIT cmd /K msys2_dependencies\batch_1
