PROG        ?= firmware
ARCH        ?= esp32c3
MDK         ?= $(realpath $(dir $(lastword $(MAKEFILE_LIST)))/..)
ESPUTIL     ?= $(MDK)/tools/esputil.exe
CFLAGS      ?= -W -Wall -Wextra -fno-builtin-printf -g -Wundef -Wshadow -pedantic \
               -Wdouble-promotion -fno-common -Wconversion \
               -march=rv32imc -mabi=ilp32 \
               -Os -ffunction-sections -fdata-sections \
               -I. -I$(MDK)/$(ARCH) $(EXTRA_CFLAGS)
LINKFLAGS   ?= -T$(MDK)/$(ARCH)/link.ld -nostdlib -nostartfiles -Wl,--gc-sections $(EXTRA_LINKFLAGS)
CWD         ?= $(realpath $(CURDIR))
FLASH_ADDR  ?= 0  # 2nd stage bootloader flash offset
TOOLCHAIN   ?= ../xpack-riscv-none-embed-gcc-10.2.0-1.2/bin/
SRCS        ?= $(MDK)/$(ARCH)/boot.c $(MDK)/$(ARCH)/vector.S  $(SOURCES) 

build: $(PROG).bin

$(PROG).elf: $(SRCS)
	$(TOOLCHAIN)riscv-none-embed-gcc  $(CFLAGS) $(SRCS) $(LINKFLAGS) -o $@
#	$(TOOLCHAIN)-size $@

$(PROG).bin: $(PROG).elf $(ESPUTIL)
	$(ESPUTIL) mkbin $(PROG).elf $@

flash: $(PROG).bin $(ESPUTIL)
	$(ESPUTIL) flash $(FLASH_ADDR) $(PROG).bin

monitor: $(ESPUTIL)
	$(ESPUTIL) monitor

$(ESPUTIL): $(MDK)/tools/esputil.c
	make -C $(MDK)/tools esputil

clean:
	@rm -rf *.{bin,elf,map,lst,tgz,zip,hex} $(PROG)*

