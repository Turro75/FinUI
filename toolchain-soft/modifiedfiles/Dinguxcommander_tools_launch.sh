#!/bin/sh

cd $(dirname "$0")

LD_PRELOAD=/mnt/sdcard/.system/rg35xx/lib/libSDL-1.2.so.0.11.4 ./DinguxCommander.elf