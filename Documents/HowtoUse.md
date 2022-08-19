## *Using the extension*

> **NOTE:**  When Using **ERS** extension you should **always** use the SDK_Setup folder as your workspace.

This tutorial will guide you through what the extension provides, as well as how to use all the commands that come with it.

 - First, the extension is activated when a command is evoked or when the SDK_Setup folder is chosen as your workspace. If active, your side bar (the blue bar on the lower side vscode window) should have the following aspect:
<img src="https://user-images.githubusercontent.com/35406517/182361006-486d033e-1ead-4963-a822-5521817ca3fe.png" width="300">

 - The side bar contain the following commands:
  
    <img src="https://user-images.githubusercontent.com/35406517/182362801-6c314ef9-3961-4260-8681-4fbf961173fe.png" width="300">
  
    **1:**`ERS:Download and Install`
    **2:**`ERS:Build`
    **3:**`ERS:Download and Install`
    **4:**`ERS:Flash`
    **5:**`ERS:Run OpenOcd Server`
    
  - After install the extension you should run **`ERS:Donwload and Install`** command as described in [![Tutorials](https://img.shields.io/badge/-Tutorials-red)](./install.md)
  
  -  Now you can create a new project! For instance, you can use the **`ERS:Create new project`** command. A prompt will appear where you can introduce the project name.
  
  <img src="https://user-images.githubusercontent.com/35406517/182379820-1aca852c-3f12-4ba7-8ade-9e94723952ed.png" width="400">
  - Once the project name is introduced a new prompt will appear where the user can select the type of the project, that being an assembly or a C project.
 <img src ="https://user-images.githubusercontent.com/35406517/185635248-cfdac0dd-abf7-46fa-bd4b-a19eb68d0601.png" width="400">

   
  A folder will appear on examples directory with a Makefile and Sources and Include directorys where you can put your **.c\asm** and **.h** files respectively
  > **NOTE:**  Dont forget to save the generated Makefile, .c\asm and .h files you have created before trying the next command.

  <img src="https://user-images.githubusercontent.com/35406517/182382149-03f03abe-5587-4364-9f39-18114cf8c712.png " width="200">
  
  - Run the **`ERS:Build`** command once you have written some code. You **must** perform this command while a source file from the project you wish to build is open in the vscode text editor; this is necessary because the path used by the command to build is retrieved by the currently open text editor. When successfully executed, the generated binary file (e.g `example.bin\example.elf`), used for flashing, should appear in the project folder.
  
  -  With the project compiled, you can now flash it to the board using **`ERS:Flash`** command. When executed, a prompt will appear where you can select the serial port you wish to use:
  
   <img src= "https://user-images.githubusercontent.com/35406517/182386735-0b3d0a13-d109-43a3-8855-9a2fdaaddc16.png" width="400">
   
   - - The 5th command, **`ERS:Run OpenOcd Server`** is used for debug wich  is explained here: [![Tutorials](https://img.shields.io/badge/-Tutorials-red)](./debug.md)
  

 



