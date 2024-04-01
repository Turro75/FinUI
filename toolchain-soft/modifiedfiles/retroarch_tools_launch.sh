#!/bin/sh

RA_HOME = /mnt/sdcard/Bios/RETROARCH
cd ${RA_HOME}
LD_PRELOAD=/mnt/sdcard/.system/rg35xx/lib/libSDL-1.2.so.0.11.4 retroarch.elf --features -v &> "$LOGS_PATH/RetroArchFeatures.txt"
LD_PRELOAD=/mnt/sdcard/.system/rg35xx/lib/libSDL-1.2.so.0.11.4 retroarch.elf --help -v &> "$LOGS_PATH/RetroArchHelp.txt"
LD_PRELOAD=/mnt/sdcard/.system/rg35xx/lib/libSDL-1.2.so.0.11.4 retroarch.elf --config=${RA_HOME}/retroarch.cfg --menu -v &> "$LOGS_PATH/RetroArch.txt"
