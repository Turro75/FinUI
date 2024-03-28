#!/bin/sh

EMU_EXE=prboom
#CPU_OC=${CPU_SPEED_PERF} # 1.3 GHz
#CPU_OC=${CPU_SPEED_MAX}  # 1.5 GHz
CPU_OC=${CPU_SPEED_GAME}  # 1.0 GHz


###############################


EMU_TAG=$(basename "$(dirname "$0")" .pak)
ROM="$1"
mkdir -p "$BIOS_PATH/$EMU_TAG"
mkdir -p "$SAVES_PATH/$EMU_TAG"
mkdir -p "${USERDATA_PATH}/${EMU_TAG}-${EMU_EXE}"

CORES_PATH="$(dirname "$0")"

#create custom cfg for retroarch
if [ ! -f "${CORES_PATH}/specialcfg.cfg" ]; then
echo "system_directory = \"~/Bios/$EMU_TAG\"" > "${CORES_PATH}/specialcfg.cfg"
echo "rgui_config_directory = \"${USERDATA_PATH}/${EMU_TAG}-${EMU_EXE}\"" >> "${CORES_PATH}/specialcfg.cfg"
echo "cheat_database_path = \"~/Bios/$EMU_TAG/cheats\"" >> "${CORES_PATH}/specialcfg.cfg"
echo "input_remapping_directory = \"~/Bios/$EMU_TAG/config/remaps\"" >> "${CORES_PATH}/specialcfg.cfg"
echo "recording_output_directory = \"~/Saves/$EMU_TAG\"" >> "${CORES_PATH}/specialcfg.cfg"
echo "savefile_directory = \"~/Saves/${EMU_TAG}\"" >> "${CORES_PATH}/specialcfg.cfg"
echo "savestate_directory = \"${USERDATA_PATH}/${EMU_TAG}-${EMU_EXE}\"" >> "${CORES_PATH}/specialcfg.cfg"
echo "screenshot_directory = \"~/Saves/${EMU_TAG}\"" >> "${CORES_PATH}/specialcfg.cfg"
echo "system_directory = \"~/Bios/${EMU_TAG}\"" >> "${CORES_PATH}/specialcfg.cfg"
fi


RA_HOME="${BIOS_PATH}/RETROARCH"
cd "$RA_HOME"
overclock.elf ${CPU_OC}
retroarch.elf -v --config ${RA_HOME}/retroarch.cfg --appendconfig "${CORES_PATH}/specialcfg.cfg" -L "$CORES_PATH/${EMU_EXE}_libretro.so" "$ROM" &> "$LOGS_PATH/$EMU_TAG.txt"
overclock.elf ${CPU_SPEED_MENU}