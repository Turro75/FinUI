#!/bin/sh

EMU_EXE=prboom
CORES_PATH=$(dirname "$0")

###############################


###############################
EMU_TAG=$(basename "$(dirname "$0")" .pak)
ROM="$1"
mkdir -p "$BIOS_PATH/$EMU_TAG"
mkdir -p "$SAVES_PATH/$EMU_TAG"

#create custom cfg for retroarch
if [ ! -f "${CORES_PATH}/specialcfg.cfg" ]; then
echo "system_directory = \"~/Bios/$EMU_TAG\"" > "${CORES_PATH}/specialcfg.cfg"
echo "rgui_config_directory = \"~/Bios/$EMU_TAG/config\"" >> "${CORES_PATH}/specialcfg.cfg"
echo "cheat_database_path = \"~/Bios/$EMU_TAG/cheats\"" >> "${CORES_PATH}/specialcfg.cfg"
echo "input_remapping_directory = \"~/Bios/$EMU_TAG/config/remaps\"" >> "${CORES_PATH}/specialcfg.cfg"
echo "recording_output_directory = \"~/Saves/$EMU_TAG\"" >> "${CORES_PATH}/specialcfg.cfg"
echo "savefile_directory = \"~/Saves/${EMU_TAG}\"" >> "${CORES_PATH}/specialcfg.cfg"
echo "savestate_directory = \"~/Saves/${EMU_TAG}\"" >> "${CORES_PATH}/specialcfg.cfg"
echo "screenshot_directory = \"~/Saves/${EMU_TAG}\"" >> "${CORES_PATH}/specialcfg.cfg"
echo "system_directory = \"~/Bios/${EMU_TAG}\"" >> "${CORES_PATH}/specialcfg.cfg"
fi


RA_HOME="${BIOS_PATH}/RETROARCH"
cd "$RA_HOME"
retroarch.elf -v --config ${RA_HOME}/retroarch.cfg --appendconfig "${CORES_PATH}/specialcfg.cfg" -L "$CORES_PATH/${EMU_EXE}_libretro.so" "$ROM" &> "$LOGS_PATH/$EMU_TAG.txt"
