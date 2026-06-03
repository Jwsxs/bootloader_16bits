#!/bin/bash
SRC=./boot_rm.s

BOOT_L=boot_l.bin

LD_FLAGS="-Ttext 0x7c00 --oformat binary"
AS_FLAGS=""

QEMU_="qemu-system-x86_64"

comp_boot() {
	# first assembly it
	as $AS_FLAGS "$1" -o obj.o
	ld_boot "obj.o"
}

ld_boot() {
	# now link it
	ld $LD_FLAGS "$1" -o "$BOOT_L"
}

if [ -f "$SRC" ]; then
	comp_boot "$SRC"
fi

if [ -f "$BOOT_L" ]; then
	$QEMU_ -drive format=raw,file="$BOOT_L"
else
	echo -e "Some kinda error occurred!\n"
fi
