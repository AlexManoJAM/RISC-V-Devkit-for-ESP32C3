## *Installation and Setup*

 1.  Download and install  [Visual Studio Code](https://code.visualstudio.com/).
    
 2.  Open the  **Extensions**  view by clicking on the Extension icon in the Activity Bar on the side of Visual Studio Code or the  **View: Extensions**  command  ⇧  ⌘  X.
    
 3.  Search the extension with any related keyword like  `RISC-V`,  `ESP32C3`,  `ERS`, etc.
    
 4.  Install the extension.
    
 5. Use command: `ERS:Donwload and Install` via the **Command Palette (Ctrl+Shift+P)**.

 6. Click on the Download button.

<img src="https://user-images.githubusercontent.com/35406517/182345552-572e06ce-4697-42ab-831a-a026a9efc5b3.png" width="500">

 7. Extract the downloaded file.

<img src="https://user-images.githubusercontent.com/35406517/182346586-af0a5db1-9430-41cc-9e2d-f1bb7d3a4fc7.png" width="600">

 8. Run the setup.bat file loacated inside SDK_Setup folder.
 
 <img src="https://user-images.githubusercontent.com/35406517/182347231-ce0b7dc8-6b86-4a28-ad75-29d474e9a4f4.png" width="800"> 
 
 The batch file will install all the dependencies and tools needed to run the extension. The following sequence will happen:

 - Install **msys2** to provide up-to-date native builds for GCC
  <img src="https://user-images.githubusercontent.com/35406517/182353294-034fccc6-5bcb-446c-b177-7f94db6a81f2.png" width="300">

 - Download xpack-riscv-none-embed-gcc toolchain wich include both compiler and debuger (gcc and gdb) .
 
 - Download ERS framework and vscode `launch.json` file used for debug setup.

 - Download OpenOcd binarys for windows with esp32c3 scripts.

 - Install all msys2 necessary packages.

After setup.batch is fully executed you should get a folder with the following items:

<img src="https://user-images.githubusercontent.com/35406517/182357478-ca6efcd6-780c-4d27-8528-94e6d4f1b35d.png" width="400">



