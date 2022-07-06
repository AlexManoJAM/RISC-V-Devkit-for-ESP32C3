rem Bypass "Terminate Batch Job" prompt.
if "%~1"=="-FIXED_CTRL_C" (
   REM Remove the -FIXED_CTRL_C parameter
   SHIFT
) ELSE (
   REM Run the batch with <NUL and -FIXED_CTRL_C
   CALL <NUL %0 -FIXED_CTRL_C %*
   GOTO :EOF
)
IF EXIST msys2-x86_64-20220603.exe (
   START /WAIT msys2-x86_64-20220603.exe
   ) else (
       powershell -Command "& {[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -UseBasicParsing 'https://github.com/msys2/msys2-installer/releases/download/2022-06-03/msys2-x86_64-20220603.exe' -OutFile msys2-x86_64-20220603.exe  }" 
       START /WAIT msys2-x86_64-20220603.exe 
       )

IF EXIST xpack-riscv-none-embed-gcc-10.2.0-1.2\ (
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

IF EXIST esp32c3-SDK-main (
    echo Framework already extracted
    ) else (
    powershell -Command "& {[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -UseBasicParsing 'https://github.com/AlexManoJAM/esp32c3-SDK/archive/refs/heads/main.zip' -OutFile main.zip }" 
    tar -xf main.zip
    )
IF EXIST esp32c3-SDK-main\openocd-esp32.zip (
    tar -xf esp32c3-SDK-main\openocd-esp32.zip
    DEL esp32c3-SDK-main\openocd-esp32.zip
    )

IF EXIST  main.zip (
    echo deleting Framework zip
    Del main.zip
    )    


for /F "delims=" %%I in ('dir /B /S "\msys64\usr\bin\bash.exe"') do set DIRPATH=%%I
set DIRPATH=%DIRPATH:bash.exe=%
echo %DIRPATH% > esp32c3-SDK-main\mdk-main\tools\msys2_path.txt
Set PATH=%DIRPATH%
echo 1 >instalation_verification.txt
pause
START /WAIT cmd /K msys2_dependencies\batch_1


