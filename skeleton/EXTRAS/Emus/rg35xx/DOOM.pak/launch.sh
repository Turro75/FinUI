#!/bin/sh

EMU_EXE=prboom
CORES_PATH=$(dirname "$0")

###############################

EMU_TAG=$(basename "$(dirname "$0")" .pak)
ROM="$1"
mkdir -p "$BIOS_PATH/$EMU_TAG"
mkdir -p "$SAVES_PATH/$EMU_TAG"

RA_HOME="${BIOS_PATH}/RETROARCH"
cd "$RA_HOME"
retroarch.elf -v --config ${RA_HOME}/retroarch.cfg --appendconfig "${BIOS_PATH}/${EMU_TAG}/${EMU_TAG}_specialcfg.cfg" -L "$CORES_PATH/${EMU_EXE}_libretro.so" "$ROM" &> "$LOGS_PATH/$EMU_TAG.txt"
