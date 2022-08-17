cd %PATH%
bash -l -c "pacman -S make && pacman -Syu && pacman -S --needed base-devel mingw-w64-x86_64-toolchain && pacman -S mingw-w64-x86_64-cmake"
