#!/bin/sh

export SDCARD_PATH="/mnt/sdcard"
export BIOS_PATH="$SDCARD_PATH/Bios"
export SAVES_PATH="$SDCARD_PATH/Saves"
export SYSTEM_PATH="$SDCARD_PATH/.system/rg35xx"
export CORES_PATH="$SYSTEM_PATH/cores"
export USERDATA_PATH="$SDCARD_PATH/.userdata/rg35xx"
export LOGS_PATH="$USERDATA_PATH/logs"

#######################################

export PATH=$SYSTEM_PATH/bin:$PATH
export LD_LIBRARY_PATH=$SYSTEM_PATH/lib:$LD_LIBRARY_PATH

#######################################

echo noop > /sys/devices/b0238000.mmc/mmc_host/mmc0/emmc_boot_card/block/mmcblk0/queue/scheduler
echo noop > /sys/devices/b0230000.mmc/mmc_host/mmc1/sd_card/block/mmcblk1/queue/scheduler
echo on > /sys/devices/b0238000.mmc/mmc_host/mmc0/power/control
echo on > /sys/devices/b0230000.mmc/mmc_host/mmc1/power/control

export CPU_SPEED_MENU=504000 # 500 MHz
export CPU_SPEED_GAME=1008000 # 1.0 GHz
export CPU_SPEED_PERF=1296000 # 1.3 GHz
echo userspace > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor

# Enable all cores (0, 1, 2, 3)
#echo 0xf > /sys/devices/system/cpu/autoplug/plug_mask
# Enable core 0 and 1 (but use 0 only)
echo 0x3 > /sys/devices/system/cpu/autoplug/plug_mask
echo 0 > /sys/devices/system/cpu/cpu1/online

#######################################

mkdir -p "$LOGS_PATH"
mkdir -p "$USERDATA_PATH/.minui"
AUTO_PATH=$USERDATA_PATH/auto.sh
if [ -f "$AUTO_PATH" ]; then
	"$AUTO_PATH" # &> $LOGS_PATH/auto.txt
fi

cd $(dirname "$0")

#######################################

keymon.elf & # &> $LOGS_PATH/keymon.txt &
# ./batmon.sh &> /mnt/sdcard/batmon.txt &

#######################################

EXEC_PATH=/tmp/minui_exec
NEXT_PATH="/tmp/next"
touch "$EXEC_PATH" && sync
while [ -f "$EXEC_PATH" ]; do
	overclock.elf $CPU_SPEED_PERF
	./minui.elf &> $LOGS_PATH/minui.txt
	sync

	if [ -f $NEXT_PATH ]; then
		CMD=`cat $NEXT_PATH`
		eval $CMD
		rm -f $NEXT_PATH
		overclock.elf $CPU_SPEED_PERF
		sync
	fi
done
