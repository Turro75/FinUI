# MyFinUI

MyFinUI is a fork of [FinUI](https://github.com/robshape/FinUI). MinUI is
a focused custom launcher for the Anbernic RG35XX. FinUI adds additional features
on top of MinUI. MyFinUi adds more features to FinUI:

1)  added Retroarch 1.14 as alternative libretro frontend for cores it has the same video filters available on garlicos.
2)  added prboom libretro core (Doom), it works only with retroarch as libretro frontend
3)  added puae2021 libretro core (Amiga), not really tested, expect issues, please report
4)  added FinalBurnNeo libretro core, it works surprisingly well on some arcade game which are slow on other OS, use
    an FBNeo romset as many 0.78 roms (mame2003+) don't work well.
5)  replaced dinguxcommander with the garlicos version (source rg35xx.com) which has more features
6)  added input tester (source latest MinUI)
7)  reduced footprint of the docker toolchain from 4.5GB down to 1.5GB.
8)  the power button now perform a shutdown as garlicos 1.4.9 does instead of standby
9)  various improvements on makefiles
10) to use retroarch instead of minarch just copy to the ROMS/Extras/Emus/xxxx.pak the launch.sh from ROMS/Extras/Emus/Doom.pak then set the right core name and the cpu speed required.

# FinUI

# FinUI

FinUI is a fork of [MinUI](https://github.com/shauninman/union-minui/). MinUI is
a focused custom launcher for the Anbernic RG35XX. FinUI adds additional features
on top of MinUI.

![FinUI](./github/minui-menu-gbc.png)

## Features

### MinUI features

- Simple launcher, simple SD card
- No settings or configuration
- No boxart, themes, or distractions
- Automatically hides extension
  and region/version cruft in
  display names
- Consistent in-emulator menu with
  quick access to save states, disc
  changing, and emulator options
- Automatically sleeps after 30 seconds
  or press POWER to sleep (and wake)
- Automatically powers off while asleep
  after two minutes or hold POWER for
  one second
- Automatically resumes right where
  you left off if powered off while
  in-game, manually or while asleep
- Resume from manually created, last
  used save state by pressing X in
  the launcher instead of A
- Streamlined emulator frontend
  (minarch + libretro cores)

### Additional FinUI features

- Add to Favorites
- Clear "Recently Played"
- Power saving improvements
- Performance improvements
- Multi-core CPU support
- Battery reading adjustments
- Additional emulators (MAME)
- Base and Extras are merged into one Full release
- Native macOS installation instructions
- Developer experience improvements

## Development

### Prerequisites

- [Docker Desktop](https://docker.com/products/docker-desktop/)

### Build project

Run `./start-toolchain.sh` and then run `make all` in the Docker container shell.

### Debug project

Create a file with the name `enableADB` on the `misc` disk to enable ADB.

### Install release

Update `DISK_PATH` and then run `./install-release.sh`.

## Disclaimer

This software is provided without warranty of any kind. In no event shall the authors
or contributors be liable for any claim, damages, or other liability, arising from,
out of, or in connection with this software, the use of this software, or other
dealings with this software.

Use at your own risk.
